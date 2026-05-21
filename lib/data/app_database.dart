import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/widgets.dart' show BuildContext, InheritedNotifier;
import 'package:path_provider/path_provider.dart';
import 'package:solicitudes_movilidad_academica/model/record_model.dart';

part 'app_database.g.dart';

class UserRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  TextColumn get role => text()();
}

class MobilityApplicationRecords extends Table {
  TextColumn get id => text()();
  TextColumn get userEmail => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get documentType => text()();
  TextColumn get documentNumber => text()();
  DateTimeColumn get birthDate => dateTime()();
  TextColumn get institutionalEmail => text()();
  TextColumn get personalEmail => text()();
  TextColumn get phone => text()();
  TextColumn get emergencyContact => text()();
  TextColumn get relationship => text()();
  TextColumn get currentUniversity => text()();
  TextColumn get faculty => text()();
  TextColumn get program => text()();
  IntColumn get currentSemester => integer()();
  RealColumn get average => real()();
  TextColumn get languageLevel => text()();
  TextColumn get languageScore => text()();
  TextColumn get destinationUniversity => text()();
  TextColumn get country => text()();
  TextColumn get city => text()();
  TextColumn get destinationFaculty => text()();
  TextColumn get studyArea => text()();
  TextColumn get exchangeSemester => text()();
  DateTimeColumn get travelDate => dateTime()();
  DateTimeColumn get returnDate => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get adminComment => text().withDefault(const Constant(''))();
  TextColumn get rejectionReason => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [UserRecords, MobilityApplicationRecords])
class AppDatabase extends _$AppDatabase with ChangeNotifier {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection()) {
    unawaited(_initialize());
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'solicitudes_movilidad_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }

  final List<AppUser> _usersCache = [];
  final List<MobilityApplication> _applicationsCache = [];

  AppUser? currentUser;
  bool isBusy = false;
  String? authError;
  int _sequence = 4;

  List<MobilityApplication> get applications => List.unmodifiable(
    [..._applicationsCache]..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
  );

  List<MobilityApplication> applicationsForUser(String email) =>
      applications.where((item) => item.userEmail == email).toList();

  int get totalApplications => _applicationsCache.length;

  int countByStatus(ApplicationStatus status) =>
      _applicationsCache.where((item) => item.status == status).length;

  Stream<List<MobilityApplication>> watchApplications() {
    final query = select(mobilityApplicationRecords)
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);

    return query.watch().map(
      (rows) => rows.map(_mapApplicationRowToModel).toList(),
    );
  }

  Stream<List<MobilityApplication>> watchApplicationsForUser(String email) {
    final query = select(mobilityApplicationRecords)
      ..where((table) => table.userEmail.equals(email))
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);

    return query.watch().map(
      (rows) => rows.map(_mapApplicationRowToModel).toList(),
    );
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    isBusy = true;
    authError = null;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final normalizedEmail = email.trim().toLowerCase();
    final exists = _usersCache.any((user) => user.email == normalizedEmail);

    if (exists) {
      authError = 'Ya existe una cuenta registrada con este correo.';
      isBusy = false;
      notifyListeners();
      return false;
    }

    await into(userRecords).insert(
      UserRecordsCompanion.insert(
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        email: normalizedEmail,
        password: password,
        role: role.name,
      ),
    );

    await _reloadCache();
    isBusy = false;
    notifyListeners();
    return true;
  }

  Future<bool> login({required String email, required String password}) async {
    isBusy = true;
    authError = null;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final normalizedEmail = email.trim().toLowerCase();

    try {
      currentUser = _usersCache.firstWhere(
        (user) => user.email == normalizedEmail && user.password == password,
      );
      isBusy = false;
      notifyListeners();
      return true;
    } catch (_) {
      authError = 'Correo o contrasena incorrectos.';
      isBusy = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    currentUser = null;
    authError = null;
    notifyListeners();
  }

  Future<void> createApplication(MobilityApplication application) async {
    await _simulateAction();
    final newId = 'SOL-${_sequence.toString().padLeft(3, '0')}';

    await into(
      mobilityApplicationRecords,
    ).insert(_applicationCompanion(application.copyWith(id: newId)));

    _sequence++;
    await _reloadCache();
    notifyListeners();
  }

  Future<void> updateApplication(MobilityApplication application) async {
    await _simulateAction();

    await update(mobilityApplicationRecords).replace(
      MobilityApplicationRecord(
        id: application.id,
        userEmail: application.userEmail,
        createdAt: application.createdAt,
        firstName: application.firstName,
        lastName: application.lastName,
        documentType: application.documentType,
        documentNumber: application.documentNumber,
        birthDate: application.birthDate,
        institutionalEmail: application.institutionalEmail,
        personalEmail: application.personalEmail,
        phone: application.phone,
        emergencyContact: application.emergencyContact,
        relationship: application.relationship,
        currentUniversity: application.currentUniversity,
        faculty: application.faculty,
        program: application.program,
        currentSemester: application.currentSemester,
        average: application.average,
        languageLevel: application.languageLevel,
        languageScore: application.languageScore,
        destinationUniversity: application.destinationUniversity,
        country: application.country,
        city: application.city,
        destinationFaculty: application.destinationFaculty,
        studyArea: application.studyArea,
        exchangeSemester: application.exchangeSemester,
        travelDate: application.travelDate,
        returnDate: application.returnDate,
        status: application.status.name,
        adminComment: application.adminComment,
        rejectionReason: application.rejectionReason,
      ),
    );

    await _reloadCache();
    notifyListeners();
  }

  Future<void> deleteApplication(String id) async {
    await _simulateAction();

    await (delete(
      mobilityApplicationRecords,
    )..where((table) => table.id.equals(id))).go();

    await _reloadCache();
    notifyListeners();
  }

  Future<void> reviewApplication({
    required String id,
    required ApplicationStatus status,
    required String comment,
    String rejectionReason = '',
  }) async {
    await _simulateAction();

    await (update(
      mobilityApplicationRecords,
    )..where((table) => table.id.equals(id))).write(
      MobilityApplicationRecordsCompanion(
        status: Value(status.name),
        adminComment: Value(comment.trim()),
        rejectionReason: Value(rejectionReason.trim()),
      ),
    );

    await _reloadCache();
    notifyListeners();
  }

  Future<List<AppUser>> getAllUsers() async {
    final rows = await select(userRecords).get();
    return rows.map(_mapUserRowToModel).toList();
  }

  Future<List<MobilityApplication>> getAllApplications() async {
    final rows = await (select(
      mobilityApplicationRecords,
    )..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).get();
    return rows.map(_mapApplicationRowToModel).toList();
  }

  Future<void> upsertApplicationFromRemote(MobilityApplication application) {
    return into(
      mobilityApplicationRecords,
    ).insertOnConflictUpdate(_applicationCompanion(application));
  }

  Future<void> _initialize() async {
    await _seedDemoDataIfNeeded();
    await _reloadCache();
    notifyListeners();
  }

  Future<void> _seedDemoDataIfNeeded() async {
    final userCountExpression = userRecords.id.count();
    final userCountQuery = selectOnly(userRecords)
      ..addColumns([userCountExpression]);
    final userCountRow = await userCountQuery.getSingle();
    final userCount = userCountRow.read(userCountExpression) ?? 0;

    if (userCount == 0) {
      await batch((batch) {
        batch.insertAll(userRecords, [
          UserRecordsCompanion.insert(
            firstName: 'Ana',
            lastName: 'Admin',
            email: 'admin@xchange.edu.co',
            password: 'Admin123',
            role: UserRole.admin.name,
          ),
          UserRecordsCompanion.insert(
            firstName: 'Sara',
            lastName: 'Estudiante',
            email: 'user@xchange.edu.co',
            password: 'User12345',
            role: UserRole.user.name,
          ),
        ]);
      });
    }

    final applicationCountExpression = mobilityApplicationRecords.id.count();
    final applicationCountQuery = selectOnly(mobilityApplicationRecords)
      ..addColumns([applicationCountExpression]);
    final applicationCountRow = await applicationCountQuery.getSingle();
    final applicationCount =
        applicationCountRow.read(applicationCountExpression) ?? 0;

    if (applicationCount == 0) {
      final demoApplications = [
        MobilityApplication(
          id: 'SOL-001',
          userEmail: 'user@xchange.edu.co',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          firstName: 'Sara',
          lastName: 'Estudiante',
          documentType: 'CC',
          documentNumber: '1032456789',
          birthDate: DateTime(2003, 3, 15),
          institutionalEmail: 'sara@udem.edu.co',
          personalEmail: 'sara.personal@email.com',
          phone: '3001234567',
          emergencyContact: 'Marta Estudiante',
          relationship: 'Madre',
          currentUniversity: 'Universidad de Medellin',
          faculty: 'Ingenieria',
          program: 'Ingenieria de Software',
          currentSemester: 7,
          average: 4.2,
          languageLevel: 'B2',
          languageScore: 'TOEFL 90',
          destinationUniversity: 'Universidad de Valencia',
          country: 'Espana',
          city: 'Valencia',
          destinationFaculty: 'Escuela Tecnica Superior',
          studyArea: 'Desarrollo de Software',
          exchangeSemester: '2026-2',
          travelDate: DateTime.now().add(const Duration(days: 120)),
          returnDate: DateTime.now().add(const Duration(days: 280)),
        ),
        MobilityApplication(
          id: 'SOL-002',
          userEmail: 'user@xchange.edu.co',
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
          firstName: 'Sara',
          lastName: 'Estudiante',
          documentType: 'CC',
          documentNumber: '1032456789',
          birthDate: DateTime(2003, 3, 15),
          institutionalEmail: 'sara@udem.edu.co',
          personalEmail: 'sara.personal@email.com',
          phone: '3001234567',
          emergencyContact: 'Marta Estudiante',
          relationship: 'Madre',
          currentUniversity: 'Universidad de Medellin',
          faculty: 'Ingenieria',
          program: 'Ingenieria de Software',
          currentSemester: 7,
          average: 4.2,
          languageLevel: 'B2',
          languageScore: 'IELTS 7.0',
          destinationUniversity: 'Universidad de Buenos Aires',
          country: 'Argentina',
          city: 'Buenos Aires',
          destinationFaculty: 'Facultad de Ingenieria',
          studyArea: 'Analitica de Datos',
          exchangeSemester: '2026-1',
          travelDate: DateTime.now().subtract(const Duration(days: 40)),
          returnDate: DateTime.now().add(const Duration(days: 45)),
          status: ApplicationStatus.approved,
          adminComment: 'Documentacion completa y promedio destacado.',
        ),
        MobilityApplication(
          id: 'SOL-003',
          userEmail: 'user@xchange.edu.co',
          createdAt: DateTime.now().subtract(const Duration(days: 12)),
          firstName: 'Sara',
          lastName: 'Estudiante',
          documentType: 'CC',
          documentNumber: '1032456789',
          birthDate: DateTime(2003, 3, 15),
          institutionalEmail: 'sara@udem.edu.co',
          personalEmail: 'sara.personal@email.com',
          phone: '3001234567',
          emergencyContact: 'Marta Estudiante',
          relationship: 'Madre',
          currentUniversity: 'Universidad de Medellin',
          faculty: 'Ingenieria',
          program: 'Ingenieria de Software',
          currentSemester: 7,
          average: 3.9,
          languageLevel: 'B1',
          languageScore: 'DELF B1',
          destinationUniversity: 'Universite de Lille',
          country: 'Francia',
          city: 'Lille',
          destinationFaculty: 'Sciences et Technologies',
          studyArea: 'Sistemas Distribuidos',
          exchangeSemester: '2025-2',
          travelDate: DateTime.now().subtract(const Duration(days: 90)),
          returnDate: DateTime.now().subtract(const Duration(days: 10)),
          status: ApplicationStatus.rejected,
          adminComment: 'Se requiere reforzar el nivel de idioma.',
          rejectionReason: 'El soporte de idioma no cumple el minimo esperado.',
        ),
      ];

      await batch((batch) {
        batch.insertAll(
          mobilityApplicationRecords,
          demoApplications.map(_applicationCompanion).toList(),
        );
      });
    }
  }

  Future<void> _reloadCache() async {
    final userRows = await select(userRecords).get();
    final applicationRows = await select(mobilityApplicationRecords).get();

    _usersCache
      ..clear()
      ..addAll(userRows.map(_mapUserRowToModel));

    _applicationsCache
      ..clear()
      ..addAll(applicationRows.map(_mapApplicationRowToModel));

    _updateSequence();
  }

  void _updateSequence() {
    final ids = _applicationsCache
        .map((application) => application.id)
        .map((id) => int.tryParse(id.replaceFirst('SOL-', '')) ?? 0);

    final maxId = ids.isEmpty ? 0 : ids.reduce((a, b) => a > b ? a : b);
    _sequence = maxId + 1;
  }

  Future<void> _simulateAction() async {
    isBusy = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    isBusy = false;
    notifyListeners();
  }

  AppUser _mapUserRowToModel(UserRecord row) {
    return AppUser(
      firstName: row.firstName,
      lastName: row.lastName,
      email: row.email,
      password: row.password,
      role: _userRoleFromString(row.role),
    );
  }

  MobilityApplication _mapApplicationRowToModel(MobilityApplicationRecord row) {
    return MobilityApplication(
      id: row.id,
      userEmail: row.userEmail,
      createdAt: row.createdAt,
      firstName: row.firstName,
      lastName: row.lastName,
      documentType: row.documentType,
      documentNumber: row.documentNumber,
      birthDate: row.birthDate,
      institutionalEmail: row.institutionalEmail,
      personalEmail: row.personalEmail,
      phone: row.phone,
      emergencyContact: row.emergencyContact,
      relationship: row.relationship,
      currentUniversity: row.currentUniversity,
      faculty: row.faculty,
      program: row.program,
      currentSemester: row.currentSemester,
      average: row.average,
      languageLevel: row.languageLevel,
      languageScore: row.languageScore,
      destinationUniversity: row.destinationUniversity,
      country: row.country,
      city: row.city,
      destinationFaculty: row.destinationFaculty,
      studyArea: row.studyArea,
      exchangeSemester: row.exchangeSemester,
      travelDate: row.travelDate,
      returnDate: row.returnDate,
      status: _applicationStatusFromString(row.status),
      adminComment: row.adminComment,
      rejectionReason: row.rejectionReason,
    );
  }

  MobilityApplicationRecordsCompanion _applicationCompanion(
    MobilityApplication application,
  ) {
    return MobilityApplicationRecordsCompanion(
      id: Value(application.id),
      userEmail: Value(application.userEmail),
      createdAt: Value(application.createdAt),
      firstName: Value(application.firstName),
      lastName: Value(application.lastName),
      documentType: Value(application.documentType),
      documentNumber: Value(application.documentNumber),
      birthDate: Value(application.birthDate),
      institutionalEmail: Value(application.institutionalEmail),
      personalEmail: Value(application.personalEmail),
      phone: Value(application.phone),
      emergencyContact: Value(application.emergencyContact),
      relationship: Value(application.relationship),
      currentUniversity: Value(application.currentUniversity),
      faculty: Value(application.faculty),
      program: Value(application.program),
      currentSemester: Value(application.currentSemester),
      average: Value(application.average),
      languageLevel: Value(application.languageLevel),
      languageScore: Value(application.languageScore),
      destinationUniversity: Value(application.destinationUniversity),
      country: Value(application.country),
      city: Value(application.city),
      destinationFaculty: Value(application.destinationFaculty),
      studyArea: Value(application.studyArea),
      exchangeSemester: Value(application.exchangeSemester),
      travelDate: Value(application.travelDate),
      returnDate: Value(application.returnDate),
      status: Value(application.status.name),
      adminComment: Value(application.adminComment),
      rejectionReason: Value(application.rejectionReason),
    );
  }
}

class AppStateScope extends InheritedNotifier<AppDatabase> {
  const AppStateScope({
    super.key,
    required AppDatabase state,
    required super.child,
  }) : super(notifier: state);

  static AppDatabase of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope no encontrado en el arbol.');
    return scope!.notifier!;
  }
}

UserRole _userRoleFromString(String value) {
  return UserRole.values.firstWhere(
    (role) => role.name == value,
    orElse: () => UserRole.user,
  );
}

ApplicationStatus _applicationStatusFromString(String value) {
  return ApplicationStatus.values.firstWhere(
    (status) => status.name == value,
    orElse: () => ApplicationStatus.pending,
  );
}
