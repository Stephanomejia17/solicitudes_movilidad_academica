// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserRecordsTable extends UserRecords
    with TableInfo<$UserRecordsTable, UserRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    email,
    password,
    role,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
    );
  }

  @override
  $UserRecordsTable createAlias(String alias) {
    return $UserRecordsTable(attachedDatabase, alias);
  }
}

class UserRecord extends DataClass implements Insertable<UserRecord> {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  const UserRecord({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['role'] = Variable<String>(role);
    return map;
  }

  UserRecordsCompanion toCompanion(bool nullToAbsent) {
    return UserRecordsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      password: Value(password),
      role: Value(role),
    );
  }

  factory UserRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRecord(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<String>(role),
    };
  }

  UserRecord copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? role,
  }) => UserRecord(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    password: password ?? this.password,
    role: role ?? this.role,
  );
  UserRecord copyWithCompanion(UserRecordsCompanion data) {
    return UserRecord(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRecord(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, firstName, lastName, email, password, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRecord &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.password == this.password &&
          other.role == this.role);
}

class UserRecordsCompanion extends UpdateCompanion<UserRecord> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> password;
  final Value<String> role;
  const UserRecordsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
  });
  UserRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String role,
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       email = Value(email),
       password = Value(password),
       role = Value(role);
  static Insertable<UserRecord> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
    });
  }

  UserRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? email,
    Value<String>? password,
    Value<String>? role,
  }) {
    return UserRecordsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRecordsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }
}

class $MobilityApplicationRecordsTable extends MobilityApplicationRecords
    with
        TableInfo<$MobilityApplicationRecordsTable, MobilityApplicationRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MobilityApplicationRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userEmailMeta = const VerificationMeta(
    'userEmail',
  );
  @override
  late final GeneratedColumn<String> userEmail = GeneratedColumn<String>(
    'user_email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
    'document_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionalEmailMeta =
      const VerificationMeta('institutionalEmail');
  @override
  late final GeneratedColumn<String> institutionalEmail =
      GeneratedColumn<String>(
        'institutional_email',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _personalEmailMeta = const VerificationMeta(
    'personalEmail',
  );
  @override
  late final GeneratedColumn<String> personalEmail = GeneratedColumn<String>(
    'personal_email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emergencyContactMeta = const VerificationMeta(
    'emergencyContact',
  );
  @override
  late final GeneratedColumn<String> emergencyContact = GeneratedColumn<String>(
    'emergency_contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationshipMeta = const VerificationMeta(
    'relationship',
  );
  @override
  late final GeneratedColumn<String> relationship = GeneratedColumn<String>(
    'relationship',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentUniversityMeta = const VerificationMeta(
    'currentUniversity',
  );
  @override
  late final GeneratedColumn<String> currentUniversity =
      GeneratedColumn<String>(
        'current_university',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _facultyMeta = const VerificationMeta(
    'faculty',
  );
  @override
  late final GeneratedColumn<String> faculty = GeneratedColumn<String>(
    'faculty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _programMeta = const VerificationMeta(
    'program',
  );
  @override
  late final GeneratedColumn<String> program = GeneratedColumn<String>(
    'program',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentSemesterMeta = const VerificationMeta(
    'currentSemester',
  );
  @override
  late final GeneratedColumn<int> currentSemester = GeneratedColumn<int>(
    'current_semester',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _averageMeta = const VerificationMeta(
    'average',
  );
  @override
  late final GeneratedColumn<double> average = GeneratedColumn<double>(
    'average',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageLevelMeta = const VerificationMeta(
    'languageLevel',
  );
  @override
  late final GeneratedColumn<String> languageLevel = GeneratedColumn<String>(
    'language_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageScoreMeta = const VerificationMeta(
    'languageScore',
  );
  @override
  late final GeneratedColumn<String> languageScore = GeneratedColumn<String>(
    'language_score',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationUniversityMeta =
      const VerificationMeta('destinationUniversity');
  @override
  late final GeneratedColumn<String> destinationUniversity =
      GeneratedColumn<String>(
        'destination_university',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationFacultyMeta =
      const VerificationMeta('destinationFaculty');
  @override
  late final GeneratedColumn<String> destinationFaculty =
      GeneratedColumn<String>(
        'destination_faculty',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _studyAreaMeta = const VerificationMeta(
    'studyArea',
  );
  @override
  late final GeneratedColumn<String> studyArea = GeneratedColumn<String>(
    'study_area',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exchangeSemesterMeta = const VerificationMeta(
    'exchangeSemester',
  );
  @override
  late final GeneratedColumn<String> exchangeSemester = GeneratedColumn<String>(
    'exchange_semester',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _travelDateMeta = const VerificationMeta(
    'travelDate',
  );
  @override
  late final GeneratedColumn<DateTime> travelDate = GeneratedColumn<DateTime>(
    'travel_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnDateMeta = const VerificationMeta(
    'returnDate',
  );
  @override
  late final GeneratedColumn<DateTime> returnDate = GeneratedColumn<DateTime>(
    'return_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _adminCommentMeta = const VerificationMeta(
    'adminComment',
  );
  @override
  late final GeneratedColumn<String> adminComment = GeneratedColumn<String>(
    'admin_comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _rejectionReasonMeta = const VerificationMeta(
    'rejectionReason',
  );
  @override
  late final GeneratedColumn<String> rejectionReason = GeneratedColumn<String>(
    'rejection_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userEmail,
    createdAt,
    firstName,
    lastName,
    documentType,
    documentNumber,
    birthDate,
    institutionalEmail,
    personalEmail,
    phone,
    emergencyContact,
    relationship,
    currentUniversity,
    faculty,
    program,
    currentSemester,
    average,
    languageLevel,
    languageScore,
    destinationUniversity,
    country,
    city,
    destinationFaculty,
    studyArea,
    exchangeSemester,
    travelDate,
    returnDate,
    status,
    adminComment,
    rejectionReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mobility_application_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MobilityApplicationRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_email')) {
      context.handle(
        _userEmailMeta,
        userEmail.isAcceptableOrUnknown(data['user_email']!, _userEmailMeta),
      );
    } else if (isInserting) {
      context.missing(_userEmailMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentNumberMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('institutional_email')) {
      context.handle(
        _institutionalEmailMeta,
        institutionalEmail.isAcceptableOrUnknown(
          data['institutional_email']!,
          _institutionalEmailMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionalEmailMeta);
    }
    if (data.containsKey('personal_email')) {
      context.handle(
        _personalEmailMeta,
        personalEmail.isAcceptableOrUnknown(
          data['personal_email']!,
          _personalEmailMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_personalEmailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('emergency_contact')) {
      context.handle(
        _emergencyContactMeta,
        emergencyContact.isAcceptableOrUnknown(
          data['emergency_contact']!,
          _emergencyContactMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emergencyContactMeta);
    }
    if (data.containsKey('relationship')) {
      context.handle(
        _relationshipMeta,
        relationship.isAcceptableOrUnknown(
          data['relationship']!,
          _relationshipMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationshipMeta);
    }
    if (data.containsKey('current_university')) {
      context.handle(
        _currentUniversityMeta,
        currentUniversity.isAcceptableOrUnknown(
          data['current_university']!,
          _currentUniversityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentUniversityMeta);
    }
    if (data.containsKey('faculty')) {
      context.handle(
        _facultyMeta,
        faculty.isAcceptableOrUnknown(data['faculty']!, _facultyMeta),
      );
    } else if (isInserting) {
      context.missing(_facultyMeta);
    }
    if (data.containsKey('program')) {
      context.handle(
        _programMeta,
        program.isAcceptableOrUnknown(data['program']!, _programMeta),
      );
    } else if (isInserting) {
      context.missing(_programMeta);
    }
    if (data.containsKey('current_semester')) {
      context.handle(
        _currentSemesterMeta,
        currentSemester.isAcceptableOrUnknown(
          data['current_semester']!,
          _currentSemesterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentSemesterMeta);
    }
    if (data.containsKey('average')) {
      context.handle(
        _averageMeta,
        average.isAcceptableOrUnknown(data['average']!, _averageMeta),
      );
    } else if (isInserting) {
      context.missing(_averageMeta);
    }
    if (data.containsKey('language_level')) {
      context.handle(
        _languageLevelMeta,
        languageLevel.isAcceptableOrUnknown(
          data['language_level']!,
          _languageLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageLevelMeta);
    }
    if (data.containsKey('language_score')) {
      context.handle(
        _languageScoreMeta,
        languageScore.isAcceptableOrUnknown(
          data['language_score']!,
          _languageScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageScoreMeta);
    }
    if (data.containsKey('destination_university')) {
      context.handle(
        _destinationUniversityMeta,
        destinationUniversity.isAcceptableOrUnknown(
          data['destination_university']!,
          _destinationUniversityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationUniversityMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('destination_faculty')) {
      context.handle(
        _destinationFacultyMeta,
        destinationFaculty.isAcceptableOrUnknown(
          data['destination_faculty']!,
          _destinationFacultyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationFacultyMeta);
    }
    if (data.containsKey('study_area')) {
      context.handle(
        _studyAreaMeta,
        studyArea.isAcceptableOrUnknown(data['study_area']!, _studyAreaMeta),
      );
    } else if (isInserting) {
      context.missing(_studyAreaMeta);
    }
    if (data.containsKey('exchange_semester')) {
      context.handle(
        _exchangeSemesterMeta,
        exchangeSemester.isAcceptableOrUnknown(
          data['exchange_semester']!,
          _exchangeSemesterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exchangeSemesterMeta);
    }
    if (data.containsKey('travel_date')) {
      context.handle(
        _travelDateMeta,
        travelDate.isAcceptableOrUnknown(data['travel_date']!, _travelDateMeta),
      );
    } else if (isInserting) {
      context.missing(_travelDateMeta);
    }
    if (data.containsKey('return_date')) {
      context.handle(
        _returnDateMeta,
        returnDate.isAcceptableOrUnknown(data['return_date']!, _returnDateMeta),
      );
    } else if (isInserting) {
      context.missing(_returnDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('admin_comment')) {
      context.handle(
        _adminCommentMeta,
        adminComment.isAcceptableOrUnknown(
          data['admin_comment']!,
          _adminCommentMeta,
        ),
      );
    }
    if (data.containsKey('rejection_reason')) {
      context.handle(
        _rejectionReasonMeta,
        rejectionReason.isAcceptableOrUnknown(
          data['rejection_reason']!,
          _rejectionReasonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MobilityApplicationRecord map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MobilityApplicationRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_email'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_number'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      )!,
      institutionalEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}institutional_email'],
      )!,
      personalEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personal_email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      emergencyContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact'],
      )!,
      relationship: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship'],
      )!,
      currentUniversity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_university'],
      )!,
      faculty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}faculty'],
      )!,
      program: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}program'],
      )!,
      currentSemester: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_semester'],
      )!,
      average: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average'],
      )!,
      languageLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_level'],
      )!,
      languageScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_score'],
      )!,
      destinationUniversity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_university'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      destinationFaculty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_faculty'],
      )!,
      studyArea: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}study_area'],
      )!,
      exchangeSemester: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exchange_semester'],
      )!,
      travelDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}travel_date'],
      )!,
      returnDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}return_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      adminComment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admin_comment'],
      )!,
      rejectionReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rejection_reason'],
      )!,
    );
  }

  @override
  $MobilityApplicationRecordsTable createAlias(String alias) {
    return $MobilityApplicationRecordsTable(attachedDatabase, alias);
  }
}

class MobilityApplicationRecord extends DataClass
    implements Insertable<MobilityApplicationRecord> {
  final String id;
  final String userEmail;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final String documentType;
  final String documentNumber;
  final DateTime birthDate;
  final String institutionalEmail;
  final String personalEmail;
  final String phone;
  final String emergencyContact;
  final String relationship;
  final String currentUniversity;
  final String faculty;
  final String program;
  final int currentSemester;
  final double average;
  final String languageLevel;
  final String languageScore;
  final String destinationUniversity;
  final String country;
  final String city;
  final String destinationFaculty;
  final String studyArea;
  final String exchangeSemester;
  final DateTime travelDate;
  final DateTime returnDate;
  final String status;
  final String adminComment;
  final String rejectionReason;
  const MobilityApplicationRecord({
    required this.id,
    required this.userEmail,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.documentType,
    required this.documentNumber,
    required this.birthDate,
    required this.institutionalEmail,
    required this.personalEmail,
    required this.phone,
    required this.emergencyContact,
    required this.relationship,
    required this.currentUniversity,
    required this.faculty,
    required this.program,
    required this.currentSemester,
    required this.average,
    required this.languageLevel,
    required this.languageScore,
    required this.destinationUniversity,
    required this.country,
    required this.city,
    required this.destinationFaculty,
    required this.studyArea,
    required this.exchangeSemester,
    required this.travelDate,
    required this.returnDate,
    required this.status,
    required this.adminComment,
    required this.rejectionReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_email'] = Variable<String>(userEmail);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['document_type'] = Variable<String>(documentType);
    map['document_number'] = Variable<String>(documentNumber);
    map['birth_date'] = Variable<DateTime>(birthDate);
    map['institutional_email'] = Variable<String>(institutionalEmail);
    map['personal_email'] = Variable<String>(personalEmail);
    map['phone'] = Variable<String>(phone);
    map['emergency_contact'] = Variable<String>(emergencyContact);
    map['relationship'] = Variable<String>(relationship);
    map['current_university'] = Variable<String>(currentUniversity);
    map['faculty'] = Variable<String>(faculty);
    map['program'] = Variable<String>(program);
    map['current_semester'] = Variable<int>(currentSemester);
    map['average'] = Variable<double>(average);
    map['language_level'] = Variable<String>(languageLevel);
    map['language_score'] = Variable<String>(languageScore);
    map['destination_university'] = Variable<String>(destinationUniversity);
    map['country'] = Variable<String>(country);
    map['city'] = Variable<String>(city);
    map['destination_faculty'] = Variable<String>(destinationFaculty);
    map['study_area'] = Variable<String>(studyArea);
    map['exchange_semester'] = Variable<String>(exchangeSemester);
    map['travel_date'] = Variable<DateTime>(travelDate);
    map['return_date'] = Variable<DateTime>(returnDate);
    map['status'] = Variable<String>(status);
    map['admin_comment'] = Variable<String>(adminComment);
    map['rejection_reason'] = Variable<String>(rejectionReason);
    return map;
  }

  MobilityApplicationRecordsCompanion toCompanion(bool nullToAbsent) {
    return MobilityApplicationRecordsCompanion(
      id: Value(id),
      userEmail: Value(userEmail),
      createdAt: Value(createdAt),
      firstName: Value(firstName),
      lastName: Value(lastName),
      documentType: Value(documentType),
      documentNumber: Value(documentNumber),
      birthDate: Value(birthDate),
      institutionalEmail: Value(institutionalEmail),
      personalEmail: Value(personalEmail),
      phone: Value(phone),
      emergencyContact: Value(emergencyContact),
      relationship: Value(relationship),
      currentUniversity: Value(currentUniversity),
      faculty: Value(faculty),
      program: Value(program),
      currentSemester: Value(currentSemester),
      average: Value(average),
      languageLevel: Value(languageLevel),
      languageScore: Value(languageScore),
      destinationUniversity: Value(destinationUniversity),
      country: Value(country),
      city: Value(city),
      destinationFaculty: Value(destinationFaculty),
      studyArea: Value(studyArea),
      exchangeSemester: Value(exchangeSemester),
      travelDate: Value(travelDate),
      returnDate: Value(returnDate),
      status: Value(status),
      adminComment: Value(adminComment),
      rejectionReason: Value(rejectionReason),
    );
  }

  factory MobilityApplicationRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MobilityApplicationRecord(
      id: serializer.fromJson<String>(json['id']),
      userEmail: serializer.fromJson<String>(json['userEmail']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      documentType: serializer.fromJson<String>(json['documentType']),
      documentNumber: serializer.fromJson<String>(json['documentNumber']),
      birthDate: serializer.fromJson<DateTime>(json['birthDate']),
      institutionalEmail: serializer.fromJson<String>(
        json['institutionalEmail'],
      ),
      personalEmail: serializer.fromJson<String>(json['personalEmail']),
      phone: serializer.fromJson<String>(json['phone']),
      emergencyContact: serializer.fromJson<String>(json['emergencyContact']),
      relationship: serializer.fromJson<String>(json['relationship']),
      currentUniversity: serializer.fromJson<String>(json['currentUniversity']),
      faculty: serializer.fromJson<String>(json['faculty']),
      program: serializer.fromJson<String>(json['program']),
      currentSemester: serializer.fromJson<int>(json['currentSemester']),
      average: serializer.fromJson<double>(json['average']),
      languageLevel: serializer.fromJson<String>(json['languageLevel']),
      languageScore: serializer.fromJson<String>(json['languageScore']),
      destinationUniversity: serializer.fromJson<String>(
        json['destinationUniversity'],
      ),
      country: serializer.fromJson<String>(json['country']),
      city: serializer.fromJson<String>(json['city']),
      destinationFaculty: serializer.fromJson<String>(
        json['destinationFaculty'],
      ),
      studyArea: serializer.fromJson<String>(json['studyArea']),
      exchangeSemester: serializer.fromJson<String>(json['exchangeSemester']),
      travelDate: serializer.fromJson<DateTime>(json['travelDate']),
      returnDate: serializer.fromJson<DateTime>(json['returnDate']),
      status: serializer.fromJson<String>(json['status']),
      adminComment: serializer.fromJson<String>(json['adminComment']),
      rejectionReason: serializer.fromJson<String>(json['rejectionReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userEmail': serializer.toJson<String>(userEmail),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'documentType': serializer.toJson<String>(documentType),
      'documentNumber': serializer.toJson<String>(documentNumber),
      'birthDate': serializer.toJson<DateTime>(birthDate),
      'institutionalEmail': serializer.toJson<String>(institutionalEmail),
      'personalEmail': serializer.toJson<String>(personalEmail),
      'phone': serializer.toJson<String>(phone),
      'emergencyContact': serializer.toJson<String>(emergencyContact),
      'relationship': serializer.toJson<String>(relationship),
      'currentUniversity': serializer.toJson<String>(currentUniversity),
      'faculty': serializer.toJson<String>(faculty),
      'program': serializer.toJson<String>(program),
      'currentSemester': serializer.toJson<int>(currentSemester),
      'average': serializer.toJson<double>(average),
      'languageLevel': serializer.toJson<String>(languageLevel),
      'languageScore': serializer.toJson<String>(languageScore),
      'destinationUniversity': serializer.toJson<String>(destinationUniversity),
      'country': serializer.toJson<String>(country),
      'city': serializer.toJson<String>(city),
      'destinationFaculty': serializer.toJson<String>(destinationFaculty),
      'studyArea': serializer.toJson<String>(studyArea),
      'exchangeSemester': serializer.toJson<String>(exchangeSemester),
      'travelDate': serializer.toJson<DateTime>(travelDate),
      'returnDate': serializer.toJson<DateTime>(returnDate),
      'status': serializer.toJson<String>(status),
      'adminComment': serializer.toJson<String>(adminComment),
      'rejectionReason': serializer.toJson<String>(rejectionReason),
    };
  }

  MobilityApplicationRecord copyWith({
    String? id,
    String? userEmail,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    String? documentType,
    String? documentNumber,
    DateTime? birthDate,
    String? institutionalEmail,
    String? personalEmail,
    String? phone,
    String? emergencyContact,
    String? relationship,
    String? currentUniversity,
    String? faculty,
    String? program,
    int? currentSemester,
    double? average,
    String? languageLevel,
    String? languageScore,
    String? destinationUniversity,
    String? country,
    String? city,
    String? destinationFaculty,
    String? studyArea,
    String? exchangeSemester,
    DateTime? travelDate,
    DateTime? returnDate,
    String? status,
    String? adminComment,
    String? rejectionReason,
  }) => MobilityApplicationRecord(
    id: id ?? this.id,
    userEmail: userEmail ?? this.userEmail,
    createdAt: createdAt ?? this.createdAt,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    documentType: documentType ?? this.documentType,
    documentNumber: documentNumber ?? this.documentNumber,
    birthDate: birthDate ?? this.birthDate,
    institutionalEmail: institutionalEmail ?? this.institutionalEmail,
    personalEmail: personalEmail ?? this.personalEmail,
    phone: phone ?? this.phone,
    emergencyContact: emergencyContact ?? this.emergencyContact,
    relationship: relationship ?? this.relationship,
    currentUniversity: currentUniversity ?? this.currentUniversity,
    faculty: faculty ?? this.faculty,
    program: program ?? this.program,
    currentSemester: currentSemester ?? this.currentSemester,
    average: average ?? this.average,
    languageLevel: languageLevel ?? this.languageLevel,
    languageScore: languageScore ?? this.languageScore,
    destinationUniversity: destinationUniversity ?? this.destinationUniversity,
    country: country ?? this.country,
    city: city ?? this.city,
    destinationFaculty: destinationFaculty ?? this.destinationFaculty,
    studyArea: studyArea ?? this.studyArea,
    exchangeSemester: exchangeSemester ?? this.exchangeSemester,
    travelDate: travelDate ?? this.travelDate,
    returnDate: returnDate ?? this.returnDate,
    status: status ?? this.status,
    adminComment: adminComment ?? this.adminComment,
    rejectionReason: rejectionReason ?? this.rejectionReason,
  );
  MobilityApplicationRecord copyWithCompanion(
    MobilityApplicationRecordsCompanion data,
  ) {
    return MobilityApplicationRecord(
      id: data.id.present ? data.id.value : this.id,
      userEmail: data.userEmail.present ? data.userEmail.value : this.userEmail,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      institutionalEmail: data.institutionalEmail.present
          ? data.institutionalEmail.value
          : this.institutionalEmail,
      personalEmail: data.personalEmail.present
          ? data.personalEmail.value
          : this.personalEmail,
      phone: data.phone.present ? data.phone.value : this.phone,
      emergencyContact: data.emergencyContact.present
          ? data.emergencyContact.value
          : this.emergencyContact,
      relationship: data.relationship.present
          ? data.relationship.value
          : this.relationship,
      currentUniversity: data.currentUniversity.present
          ? data.currentUniversity.value
          : this.currentUniversity,
      faculty: data.faculty.present ? data.faculty.value : this.faculty,
      program: data.program.present ? data.program.value : this.program,
      currentSemester: data.currentSemester.present
          ? data.currentSemester.value
          : this.currentSemester,
      average: data.average.present ? data.average.value : this.average,
      languageLevel: data.languageLevel.present
          ? data.languageLevel.value
          : this.languageLevel,
      languageScore: data.languageScore.present
          ? data.languageScore.value
          : this.languageScore,
      destinationUniversity: data.destinationUniversity.present
          ? data.destinationUniversity.value
          : this.destinationUniversity,
      country: data.country.present ? data.country.value : this.country,
      city: data.city.present ? data.city.value : this.city,
      destinationFaculty: data.destinationFaculty.present
          ? data.destinationFaculty.value
          : this.destinationFaculty,
      studyArea: data.studyArea.present ? data.studyArea.value : this.studyArea,
      exchangeSemester: data.exchangeSemester.present
          ? data.exchangeSemester.value
          : this.exchangeSemester,
      travelDate: data.travelDate.present
          ? data.travelDate.value
          : this.travelDate,
      returnDate: data.returnDate.present
          ? data.returnDate.value
          : this.returnDate,
      status: data.status.present ? data.status.value : this.status,
      adminComment: data.adminComment.present
          ? data.adminComment.value
          : this.adminComment,
      rejectionReason: data.rejectionReason.present
          ? data.rejectionReason.value
          : this.rejectionReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MobilityApplicationRecord(')
          ..write('id: $id, ')
          ..write('userEmail: $userEmail, ')
          ..write('createdAt: $createdAt, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('birthDate: $birthDate, ')
          ..write('institutionalEmail: $institutionalEmail, ')
          ..write('personalEmail: $personalEmail, ')
          ..write('phone: $phone, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('relationship: $relationship, ')
          ..write('currentUniversity: $currentUniversity, ')
          ..write('faculty: $faculty, ')
          ..write('program: $program, ')
          ..write('currentSemester: $currentSemester, ')
          ..write('average: $average, ')
          ..write('languageLevel: $languageLevel, ')
          ..write('languageScore: $languageScore, ')
          ..write('destinationUniversity: $destinationUniversity, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('destinationFaculty: $destinationFaculty, ')
          ..write('studyArea: $studyArea, ')
          ..write('exchangeSemester: $exchangeSemester, ')
          ..write('travelDate: $travelDate, ')
          ..write('returnDate: $returnDate, ')
          ..write('status: $status, ')
          ..write('adminComment: $adminComment, ')
          ..write('rejectionReason: $rejectionReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    userEmail,
    createdAt,
    firstName,
    lastName,
    documentType,
    documentNumber,
    birthDate,
    institutionalEmail,
    personalEmail,
    phone,
    emergencyContact,
    relationship,
    currentUniversity,
    faculty,
    program,
    currentSemester,
    average,
    languageLevel,
    languageScore,
    destinationUniversity,
    country,
    city,
    destinationFaculty,
    studyArea,
    exchangeSemester,
    travelDate,
    returnDate,
    status,
    adminComment,
    rejectionReason,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MobilityApplicationRecord &&
          other.id == this.id &&
          other.userEmail == this.userEmail &&
          other.createdAt == this.createdAt &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.documentType == this.documentType &&
          other.documentNumber == this.documentNumber &&
          other.birthDate == this.birthDate &&
          other.institutionalEmail == this.institutionalEmail &&
          other.personalEmail == this.personalEmail &&
          other.phone == this.phone &&
          other.emergencyContact == this.emergencyContact &&
          other.relationship == this.relationship &&
          other.currentUniversity == this.currentUniversity &&
          other.faculty == this.faculty &&
          other.program == this.program &&
          other.currentSemester == this.currentSemester &&
          other.average == this.average &&
          other.languageLevel == this.languageLevel &&
          other.languageScore == this.languageScore &&
          other.destinationUniversity == this.destinationUniversity &&
          other.country == this.country &&
          other.city == this.city &&
          other.destinationFaculty == this.destinationFaculty &&
          other.studyArea == this.studyArea &&
          other.exchangeSemester == this.exchangeSemester &&
          other.travelDate == this.travelDate &&
          other.returnDate == this.returnDate &&
          other.status == this.status &&
          other.adminComment == this.adminComment &&
          other.rejectionReason == this.rejectionReason);
}

class MobilityApplicationRecordsCompanion
    extends UpdateCompanion<MobilityApplicationRecord> {
  final Value<String> id;
  final Value<String> userEmail;
  final Value<DateTime> createdAt;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> documentType;
  final Value<String> documentNumber;
  final Value<DateTime> birthDate;
  final Value<String> institutionalEmail;
  final Value<String> personalEmail;
  final Value<String> phone;
  final Value<String> emergencyContact;
  final Value<String> relationship;
  final Value<String> currentUniversity;
  final Value<String> faculty;
  final Value<String> program;
  final Value<int> currentSemester;
  final Value<double> average;
  final Value<String> languageLevel;
  final Value<String> languageScore;
  final Value<String> destinationUniversity;
  final Value<String> country;
  final Value<String> city;
  final Value<String> destinationFaculty;
  final Value<String> studyArea;
  final Value<String> exchangeSemester;
  final Value<DateTime> travelDate;
  final Value<DateTime> returnDate;
  final Value<String> status;
  final Value<String> adminComment;
  final Value<String> rejectionReason;
  final Value<int> rowid;
  const MobilityApplicationRecordsCompanion({
    this.id = const Value.absent(),
    this.userEmail = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.documentType = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.institutionalEmail = const Value.absent(),
    this.personalEmail = const Value.absent(),
    this.phone = const Value.absent(),
    this.emergencyContact = const Value.absent(),
    this.relationship = const Value.absent(),
    this.currentUniversity = const Value.absent(),
    this.faculty = const Value.absent(),
    this.program = const Value.absent(),
    this.currentSemester = const Value.absent(),
    this.average = const Value.absent(),
    this.languageLevel = const Value.absent(),
    this.languageScore = const Value.absent(),
    this.destinationUniversity = const Value.absent(),
    this.country = const Value.absent(),
    this.city = const Value.absent(),
    this.destinationFaculty = const Value.absent(),
    this.studyArea = const Value.absent(),
    this.exchangeSemester = const Value.absent(),
    this.travelDate = const Value.absent(),
    this.returnDate = const Value.absent(),
    this.status = const Value.absent(),
    this.adminComment = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MobilityApplicationRecordsCompanion.insert({
    required String id,
    required String userEmail,
    required DateTime createdAt,
    required String firstName,
    required String lastName,
    required String documentType,
    required String documentNumber,
    required DateTime birthDate,
    required String institutionalEmail,
    required String personalEmail,
    required String phone,
    required String emergencyContact,
    required String relationship,
    required String currentUniversity,
    required String faculty,
    required String program,
    required int currentSemester,
    required double average,
    required String languageLevel,
    required String languageScore,
    required String destinationUniversity,
    required String country,
    required String city,
    required String destinationFaculty,
    required String studyArea,
    required String exchangeSemester,
    required DateTime travelDate,
    required DateTime returnDate,
    this.status = const Value.absent(),
    this.adminComment = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userEmail = Value(userEmail),
       createdAt = Value(createdAt),
       firstName = Value(firstName),
       lastName = Value(lastName),
       documentType = Value(documentType),
       documentNumber = Value(documentNumber),
       birthDate = Value(birthDate),
       institutionalEmail = Value(institutionalEmail),
       personalEmail = Value(personalEmail),
       phone = Value(phone),
       emergencyContact = Value(emergencyContact),
       relationship = Value(relationship),
       currentUniversity = Value(currentUniversity),
       faculty = Value(faculty),
       program = Value(program),
       currentSemester = Value(currentSemester),
       average = Value(average),
       languageLevel = Value(languageLevel),
       languageScore = Value(languageScore),
       destinationUniversity = Value(destinationUniversity),
       country = Value(country),
       city = Value(city),
       destinationFaculty = Value(destinationFaculty),
       studyArea = Value(studyArea),
       exchangeSemester = Value(exchangeSemester),
       travelDate = Value(travelDate),
       returnDate = Value(returnDate);
  static Insertable<MobilityApplicationRecord> custom({
    Expression<String>? id,
    Expression<String>? userEmail,
    Expression<DateTime>? createdAt,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? documentType,
    Expression<String>? documentNumber,
    Expression<DateTime>? birthDate,
    Expression<String>? institutionalEmail,
    Expression<String>? personalEmail,
    Expression<String>? phone,
    Expression<String>? emergencyContact,
    Expression<String>? relationship,
    Expression<String>? currentUniversity,
    Expression<String>? faculty,
    Expression<String>? program,
    Expression<int>? currentSemester,
    Expression<double>? average,
    Expression<String>? languageLevel,
    Expression<String>? languageScore,
    Expression<String>? destinationUniversity,
    Expression<String>? country,
    Expression<String>? city,
    Expression<String>? destinationFaculty,
    Expression<String>? studyArea,
    Expression<String>? exchangeSemester,
    Expression<DateTime>? travelDate,
    Expression<DateTime>? returnDate,
    Expression<String>? status,
    Expression<String>? adminComment,
    Expression<String>? rejectionReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userEmail != null) 'user_email': userEmail,
      if (createdAt != null) 'created_at': createdAt,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (documentType != null) 'document_type': documentType,
      if (documentNumber != null) 'document_number': documentNumber,
      if (birthDate != null) 'birth_date': birthDate,
      if (institutionalEmail != null) 'institutional_email': institutionalEmail,
      if (personalEmail != null) 'personal_email': personalEmail,
      if (phone != null) 'phone': phone,
      if (emergencyContact != null) 'emergency_contact': emergencyContact,
      if (relationship != null) 'relationship': relationship,
      if (currentUniversity != null) 'current_university': currentUniversity,
      if (faculty != null) 'faculty': faculty,
      if (program != null) 'program': program,
      if (currentSemester != null) 'current_semester': currentSemester,
      if (average != null) 'average': average,
      if (languageLevel != null) 'language_level': languageLevel,
      if (languageScore != null) 'language_score': languageScore,
      if (destinationUniversity != null)
        'destination_university': destinationUniversity,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      if (destinationFaculty != null) 'destination_faculty': destinationFaculty,
      if (studyArea != null) 'study_area': studyArea,
      if (exchangeSemester != null) 'exchange_semester': exchangeSemester,
      if (travelDate != null) 'travel_date': travelDate,
      if (returnDate != null) 'return_date': returnDate,
      if (status != null) 'status': status,
      if (adminComment != null) 'admin_comment': adminComment,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MobilityApplicationRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? userEmail,
    Value<DateTime>? createdAt,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? documentType,
    Value<String>? documentNumber,
    Value<DateTime>? birthDate,
    Value<String>? institutionalEmail,
    Value<String>? personalEmail,
    Value<String>? phone,
    Value<String>? emergencyContact,
    Value<String>? relationship,
    Value<String>? currentUniversity,
    Value<String>? faculty,
    Value<String>? program,
    Value<int>? currentSemester,
    Value<double>? average,
    Value<String>? languageLevel,
    Value<String>? languageScore,
    Value<String>? destinationUniversity,
    Value<String>? country,
    Value<String>? city,
    Value<String>? destinationFaculty,
    Value<String>? studyArea,
    Value<String>? exchangeSemester,
    Value<DateTime>? travelDate,
    Value<DateTime>? returnDate,
    Value<String>? status,
    Value<String>? adminComment,
    Value<String>? rejectionReason,
    Value<int>? rowid,
  }) {
    return MobilityApplicationRecordsCompanion(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      birthDate: birthDate ?? this.birthDate,
      institutionalEmail: institutionalEmail ?? this.institutionalEmail,
      personalEmail: personalEmail ?? this.personalEmail,
      phone: phone ?? this.phone,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      relationship: relationship ?? this.relationship,
      currentUniversity: currentUniversity ?? this.currentUniversity,
      faculty: faculty ?? this.faculty,
      program: program ?? this.program,
      currentSemester: currentSemester ?? this.currentSemester,
      average: average ?? this.average,
      languageLevel: languageLevel ?? this.languageLevel,
      languageScore: languageScore ?? this.languageScore,
      destinationUniversity:
          destinationUniversity ?? this.destinationUniversity,
      country: country ?? this.country,
      city: city ?? this.city,
      destinationFaculty: destinationFaculty ?? this.destinationFaculty,
      studyArea: studyArea ?? this.studyArea,
      exchangeSemester: exchangeSemester ?? this.exchangeSemester,
      travelDate: travelDate ?? this.travelDate,
      returnDate: returnDate ?? this.returnDate,
      status: status ?? this.status,
      adminComment: adminComment ?? this.adminComment,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userEmail.present) {
      map['user_email'] = Variable<String>(userEmail.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (institutionalEmail.present) {
      map['institutional_email'] = Variable<String>(institutionalEmail.value);
    }
    if (personalEmail.present) {
      map['personal_email'] = Variable<String>(personalEmail.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (emergencyContact.present) {
      map['emergency_contact'] = Variable<String>(emergencyContact.value);
    }
    if (relationship.present) {
      map['relationship'] = Variable<String>(relationship.value);
    }
    if (currentUniversity.present) {
      map['current_university'] = Variable<String>(currentUniversity.value);
    }
    if (faculty.present) {
      map['faculty'] = Variable<String>(faculty.value);
    }
    if (program.present) {
      map['program'] = Variable<String>(program.value);
    }
    if (currentSemester.present) {
      map['current_semester'] = Variable<int>(currentSemester.value);
    }
    if (average.present) {
      map['average'] = Variable<double>(average.value);
    }
    if (languageLevel.present) {
      map['language_level'] = Variable<String>(languageLevel.value);
    }
    if (languageScore.present) {
      map['language_score'] = Variable<String>(languageScore.value);
    }
    if (destinationUniversity.present) {
      map['destination_university'] = Variable<String>(
        destinationUniversity.value,
      );
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (destinationFaculty.present) {
      map['destination_faculty'] = Variable<String>(destinationFaculty.value);
    }
    if (studyArea.present) {
      map['study_area'] = Variable<String>(studyArea.value);
    }
    if (exchangeSemester.present) {
      map['exchange_semester'] = Variable<String>(exchangeSemester.value);
    }
    if (travelDate.present) {
      map['travel_date'] = Variable<DateTime>(travelDate.value);
    }
    if (returnDate.present) {
      map['return_date'] = Variable<DateTime>(returnDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (adminComment.present) {
      map['admin_comment'] = Variable<String>(adminComment.value);
    }
    if (rejectionReason.present) {
      map['rejection_reason'] = Variable<String>(rejectionReason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MobilityApplicationRecordsCompanion(')
          ..write('id: $id, ')
          ..write('userEmail: $userEmail, ')
          ..write('createdAt: $createdAt, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('birthDate: $birthDate, ')
          ..write('institutionalEmail: $institutionalEmail, ')
          ..write('personalEmail: $personalEmail, ')
          ..write('phone: $phone, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('relationship: $relationship, ')
          ..write('currentUniversity: $currentUniversity, ')
          ..write('faculty: $faculty, ')
          ..write('program: $program, ')
          ..write('currentSemester: $currentSemester, ')
          ..write('average: $average, ')
          ..write('languageLevel: $languageLevel, ')
          ..write('languageScore: $languageScore, ')
          ..write('destinationUniversity: $destinationUniversity, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('destinationFaculty: $destinationFaculty, ')
          ..write('studyArea: $studyArea, ')
          ..write('exchangeSemester: $exchangeSemester, ')
          ..write('travelDate: $travelDate, ')
          ..write('returnDate: $returnDate, ')
          ..write('status: $status, ')
          ..write('adminComment: $adminComment, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserRecordsTable userRecords = $UserRecordsTable(this);
  late final $MobilityApplicationRecordsTable mobilityApplicationRecords =
      $MobilityApplicationRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userRecords,
    mobilityApplicationRecords,
  ];
}

typedef $$UserRecordsTableCreateCompanionBuilder =
    UserRecordsCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String role,
    });
typedef $$UserRecordsTableUpdateCompanionBuilder =
    UserRecordsCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> email,
      Value<String> password,
      Value<String> role,
    });

class $$UserRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $UserRecordsTable> {
  $$UserRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserRecordsTable> {
  $$UserRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserRecordsTable> {
  $$UserRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);
}

class $$UserRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserRecordsTable,
          UserRecord,
          $$UserRecordsTableFilterComposer,
          $$UserRecordsTableOrderingComposer,
          $$UserRecordsTableAnnotationComposer,
          $$UserRecordsTableCreateCompanionBuilder,
          $$UserRecordsTableUpdateCompanionBuilder,
          (
            UserRecord,
            BaseReferences<_$AppDatabase, $UserRecordsTable, UserRecord>,
          ),
          UserRecord,
          PrefetchHooks Function()
        > {
  $$UserRecordsTableTableManager(_$AppDatabase db, $UserRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> role = const Value.absent(),
              }) => UserRecordsCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                role: role,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                required String email,
                required String password,
                required String role,
              }) => UserRecordsCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                role: role,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserRecordsTable,
      UserRecord,
      $$UserRecordsTableFilterComposer,
      $$UserRecordsTableOrderingComposer,
      $$UserRecordsTableAnnotationComposer,
      $$UserRecordsTableCreateCompanionBuilder,
      $$UserRecordsTableUpdateCompanionBuilder,
      (
        UserRecord,
        BaseReferences<_$AppDatabase, $UserRecordsTable, UserRecord>,
      ),
      UserRecord,
      PrefetchHooks Function()
    >;
typedef $$MobilityApplicationRecordsTableCreateCompanionBuilder =
    MobilityApplicationRecordsCompanion Function({
      required String id,
      required String userEmail,
      required DateTime createdAt,
      required String firstName,
      required String lastName,
      required String documentType,
      required String documentNumber,
      required DateTime birthDate,
      required String institutionalEmail,
      required String personalEmail,
      required String phone,
      required String emergencyContact,
      required String relationship,
      required String currentUniversity,
      required String faculty,
      required String program,
      required int currentSemester,
      required double average,
      required String languageLevel,
      required String languageScore,
      required String destinationUniversity,
      required String country,
      required String city,
      required String destinationFaculty,
      required String studyArea,
      required String exchangeSemester,
      required DateTime travelDate,
      required DateTime returnDate,
      Value<String> status,
      Value<String> adminComment,
      Value<String> rejectionReason,
      Value<int> rowid,
    });
typedef $$MobilityApplicationRecordsTableUpdateCompanionBuilder =
    MobilityApplicationRecordsCompanion Function({
      Value<String> id,
      Value<String> userEmail,
      Value<DateTime> createdAt,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> documentType,
      Value<String> documentNumber,
      Value<DateTime> birthDate,
      Value<String> institutionalEmail,
      Value<String> personalEmail,
      Value<String> phone,
      Value<String> emergencyContact,
      Value<String> relationship,
      Value<String> currentUniversity,
      Value<String> faculty,
      Value<String> program,
      Value<int> currentSemester,
      Value<double> average,
      Value<String> languageLevel,
      Value<String> languageScore,
      Value<String> destinationUniversity,
      Value<String> country,
      Value<String> city,
      Value<String> destinationFaculty,
      Value<String> studyArea,
      Value<String> exchangeSemester,
      Value<DateTime> travelDate,
      Value<DateTime> returnDate,
      Value<String> status,
      Value<String> adminComment,
      Value<String> rejectionReason,
      Value<int> rowid,
    });

class $$MobilityApplicationRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MobilityApplicationRecordsTable> {
  $$MobilityApplicationRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userEmail => $composableBuilder(
    column: $table.userEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get institutionalEmail => $composableBuilder(
    column: $table.institutionalEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personalEmail => $composableBuilder(
    column: $table.personalEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentUniversity => $composableBuilder(
    column: $table.currentUniversity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get faculty => $composableBuilder(
    column: $table.faculty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get program => $composableBuilder(
    column: $table.program,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentSemester => $composableBuilder(
    column: $table.currentSemester,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get average => $composableBuilder(
    column: $table.average,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageLevel => $composableBuilder(
    column: $table.languageLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageScore => $composableBuilder(
    column: $table.languageScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationUniversity => $composableBuilder(
    column: $table.destinationUniversity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationFaculty => $composableBuilder(
    column: $table.destinationFaculty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studyArea => $composableBuilder(
    column: $table.studyArea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exchangeSemester => $composableBuilder(
    column: $table.exchangeSemester,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get travelDate => $composableBuilder(
    column: $table.travelDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adminComment => $composableBuilder(
    column: $table.adminComment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MobilityApplicationRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MobilityApplicationRecordsTable> {
  $$MobilityApplicationRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userEmail => $composableBuilder(
    column: $table.userEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get institutionalEmail => $composableBuilder(
    column: $table.institutionalEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personalEmail => $composableBuilder(
    column: $table.personalEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentUniversity => $composableBuilder(
    column: $table.currentUniversity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get faculty => $composableBuilder(
    column: $table.faculty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get program => $composableBuilder(
    column: $table.program,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentSemester => $composableBuilder(
    column: $table.currentSemester,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get average => $composableBuilder(
    column: $table.average,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageLevel => $composableBuilder(
    column: $table.languageLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageScore => $composableBuilder(
    column: $table.languageScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationUniversity => $composableBuilder(
    column: $table.destinationUniversity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationFaculty => $composableBuilder(
    column: $table.destinationFaculty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studyArea => $composableBuilder(
    column: $table.studyArea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exchangeSemester => $composableBuilder(
    column: $table.exchangeSemester,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get travelDate => $composableBuilder(
    column: $table.travelDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adminComment => $composableBuilder(
    column: $table.adminComment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MobilityApplicationRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MobilityApplicationRecordsTable> {
  $$MobilityApplicationRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userEmail =>
      $composableBuilder(column: $table.userEmail, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get institutionalEmail => $composableBuilder(
    column: $table.institutionalEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get personalEmail => $composableBuilder(
    column: $table.personalEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentUniversity => $composableBuilder(
    column: $table.currentUniversity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get faculty =>
      $composableBuilder(column: $table.faculty, builder: (column) => column);

  GeneratedColumn<String> get program =>
      $composableBuilder(column: $table.program, builder: (column) => column);

  GeneratedColumn<int> get currentSemester => $composableBuilder(
    column: $table.currentSemester,
    builder: (column) => column,
  );

  GeneratedColumn<double> get average =>
      $composableBuilder(column: $table.average, builder: (column) => column);

  GeneratedColumn<String> get languageLevel => $composableBuilder(
    column: $table.languageLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageScore => $composableBuilder(
    column: $table.languageScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationUniversity => $composableBuilder(
    column: $table.destinationUniversity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get destinationFaculty => $composableBuilder(
    column: $table.destinationFaculty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get studyArea =>
      $composableBuilder(column: $table.studyArea, builder: (column) => column);

  GeneratedColumn<String> get exchangeSemester => $composableBuilder(
    column: $table.exchangeSemester,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get travelDate => $composableBuilder(
    column: $table.travelDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get adminComment => $composableBuilder(
    column: $table.adminComment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => column,
  );
}

class $$MobilityApplicationRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MobilityApplicationRecordsTable,
          MobilityApplicationRecord,
          $$MobilityApplicationRecordsTableFilterComposer,
          $$MobilityApplicationRecordsTableOrderingComposer,
          $$MobilityApplicationRecordsTableAnnotationComposer,
          $$MobilityApplicationRecordsTableCreateCompanionBuilder,
          $$MobilityApplicationRecordsTableUpdateCompanionBuilder,
          (
            MobilityApplicationRecord,
            BaseReferences<
              _$AppDatabase,
              $MobilityApplicationRecordsTable,
              MobilityApplicationRecord
            >,
          ),
          MobilityApplicationRecord,
          PrefetchHooks Function()
        > {
  $$MobilityApplicationRecordsTableTableManager(
    _$AppDatabase db,
    $MobilityApplicationRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MobilityApplicationRecordsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MobilityApplicationRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MobilityApplicationRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userEmail = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> documentType = const Value.absent(),
                Value<String> documentNumber = const Value.absent(),
                Value<DateTime> birthDate = const Value.absent(),
                Value<String> institutionalEmail = const Value.absent(),
                Value<String> personalEmail = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> emergencyContact = const Value.absent(),
                Value<String> relationship = const Value.absent(),
                Value<String> currentUniversity = const Value.absent(),
                Value<String> faculty = const Value.absent(),
                Value<String> program = const Value.absent(),
                Value<int> currentSemester = const Value.absent(),
                Value<double> average = const Value.absent(),
                Value<String> languageLevel = const Value.absent(),
                Value<String> languageScore = const Value.absent(),
                Value<String> destinationUniversity = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> destinationFaculty = const Value.absent(),
                Value<String> studyArea = const Value.absent(),
                Value<String> exchangeSemester = const Value.absent(),
                Value<DateTime> travelDate = const Value.absent(),
                Value<DateTime> returnDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> adminComment = const Value.absent(),
                Value<String> rejectionReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MobilityApplicationRecordsCompanion(
                id: id,
                userEmail: userEmail,
                createdAt: createdAt,
                firstName: firstName,
                lastName: lastName,
                documentType: documentType,
                documentNumber: documentNumber,
                birthDate: birthDate,
                institutionalEmail: institutionalEmail,
                personalEmail: personalEmail,
                phone: phone,
                emergencyContact: emergencyContact,
                relationship: relationship,
                currentUniversity: currentUniversity,
                faculty: faculty,
                program: program,
                currentSemester: currentSemester,
                average: average,
                languageLevel: languageLevel,
                languageScore: languageScore,
                destinationUniversity: destinationUniversity,
                country: country,
                city: city,
                destinationFaculty: destinationFaculty,
                studyArea: studyArea,
                exchangeSemester: exchangeSemester,
                travelDate: travelDate,
                returnDate: returnDate,
                status: status,
                adminComment: adminComment,
                rejectionReason: rejectionReason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userEmail,
                required DateTime createdAt,
                required String firstName,
                required String lastName,
                required String documentType,
                required String documentNumber,
                required DateTime birthDate,
                required String institutionalEmail,
                required String personalEmail,
                required String phone,
                required String emergencyContact,
                required String relationship,
                required String currentUniversity,
                required String faculty,
                required String program,
                required int currentSemester,
                required double average,
                required String languageLevel,
                required String languageScore,
                required String destinationUniversity,
                required String country,
                required String city,
                required String destinationFaculty,
                required String studyArea,
                required String exchangeSemester,
                required DateTime travelDate,
                required DateTime returnDate,
                Value<String> status = const Value.absent(),
                Value<String> adminComment = const Value.absent(),
                Value<String> rejectionReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MobilityApplicationRecordsCompanion.insert(
                id: id,
                userEmail: userEmail,
                createdAt: createdAt,
                firstName: firstName,
                lastName: lastName,
                documentType: documentType,
                documentNumber: documentNumber,
                birthDate: birthDate,
                institutionalEmail: institutionalEmail,
                personalEmail: personalEmail,
                phone: phone,
                emergencyContact: emergencyContact,
                relationship: relationship,
                currentUniversity: currentUniversity,
                faculty: faculty,
                program: program,
                currentSemester: currentSemester,
                average: average,
                languageLevel: languageLevel,
                languageScore: languageScore,
                destinationUniversity: destinationUniversity,
                country: country,
                city: city,
                destinationFaculty: destinationFaculty,
                studyArea: studyArea,
                exchangeSemester: exchangeSemester,
                travelDate: travelDate,
                returnDate: returnDate,
                status: status,
                adminComment: adminComment,
                rejectionReason: rejectionReason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MobilityApplicationRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MobilityApplicationRecordsTable,
      MobilityApplicationRecord,
      $$MobilityApplicationRecordsTableFilterComposer,
      $$MobilityApplicationRecordsTableOrderingComposer,
      $$MobilityApplicationRecordsTableAnnotationComposer,
      $$MobilityApplicationRecordsTableCreateCompanionBuilder,
      $$MobilityApplicationRecordsTableUpdateCompanionBuilder,
      (
        MobilityApplicationRecord,
        BaseReferences<
          _$AppDatabase,
          $MobilityApplicationRecordsTable,
          MobilityApplicationRecord
        >,
      ),
      MobilityApplicationRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserRecordsTableTableManager get userRecords =>
      $$UserRecordsTableTableManager(_db, _db.userRecords);
  $$MobilityApplicationRecordsTableTableManager
  get mobilityApplicationRecords =>
      $$MobilityApplicationRecordsTableTableManager(
        _db,
        _db.mobilityApplicationRecords,
      );
}
