// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios
    with TableInfo<$UsuariosTable, UsuarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apellidoMeta = const VerificationMeta(
    'apellido',
  );
  @override
  late final GeneratedColumn<String> apellido = GeneratedColumn<String>(
    'apellido',
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
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
    'rol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('activo'),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    apellido,
    email,
    rol,
    estado,
    createdAt,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsuarioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('apellido')) {
      context.handle(
        _apellidoMeta,
        apellido.isAcceptableOrUnknown(data['apellido']!, _apellidoMeta),
      );
    } else if (isInserting) {
      context.missing(_apellidoMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
        _rolMeta,
        rol.isAcceptableOrUnknown(data['rol']!, _rolMeta),
      );
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsuarioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuarioData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      apellido: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellido'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      rol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rol'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class UsuarioData extends DataClass implements Insertable<UsuarioData> {
  final String id;
  final String nombre;
  final String apellido;
  final String email;
  final String rol;
  final String estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool pendingSync;
  const UsuarioData({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.rol,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['apellido'] = Variable<String>(apellido);
    map['email'] = Variable<String>(email);
    map['rol'] = Variable<String>(rol);
    map['estado'] = Variable<String>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      apellido: Value(apellido),
      email: Value(email),
      rol: Value(rol),
      estado: Value(estado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory UsuarioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuarioData(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      apellido: serializer.fromJson<String>(json['apellido']),
      email: serializer.fromJson<String>(json['email']),
      rol: serializer.fromJson<String>(json['rol']),
      estado: serializer.fromJson<String>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'apellido': serializer.toJson<String>(apellido),
      'email': serializer.toJson<String>(email),
      'rol': serializer.toJson<String>(rol),
      'estado': serializer.toJson<String>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  UsuarioData copyWith({
    String? id,
    String? nombre,
    String? apellido,
    String? email,
    String? rol,
    String? estado,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => UsuarioData(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    apellido: apellido ?? this.apellido,
    email: email ?? this.email,
    rol: rol ?? this.rol,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  UsuarioData copyWithCompanion(UsuariosCompanion data) {
    return UsuarioData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      apellido: data.apellido.present ? data.apellido.value : this.apellido,
      email: data.email.present ? data.email.value : this.email,
      rol: data.rol.present ? data.rol.value : this.rol,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('email: $email, ')
          ..write('rol: $rol, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    apellido,
    email,
    rol,
    estado,
    createdAt,
    updatedAt,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.apellido == this.apellido &&
          other.email == this.email &&
          other.rol == this.rol &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class UsuariosCompanion extends UpdateCompanion<UsuarioData> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> apellido;
  final Value<String> email;
  final Value<String> rol;
  final Value<String> estado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.apellido = const Value.absent(),
    this.email = const Value.absent(),
    this.rol = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosCompanion.insert({
    required String id,
    required String nombre,
    required String apellido,
    required String email,
    required String rol,
    this.estado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       apellido = Value(apellido),
       email = Value(email),
       rol = Value(rol),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UsuarioData> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? apellido,
    Expression<String>? email,
    Expression<String>? rol,
    Expression<String>? estado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      if (email != null) 'email': email,
      if (rol != null) 'rol': rol,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String>? apellido,
    Value<String>? email,
    Value<String>? rol,
    Value<String>? estado,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      email: email ?? this.email,
      rol: rol ?? this.rol,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (apellido.present) {
      map['apellido'] = Variable<String>(apellido.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('apellido: $apellido, ')
          ..write('email: $email, ')
          ..write('rol: $rol, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SolicitudMovilidadTable extends SolicitudMovilidad
    with TableInfo<$SolicitudMovilidadTable, SolicitudMobilidadData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SolicitudMovilidadTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estudianteIdMeta = const VerificationMeta(
    'estudianteId',
  );
  @override
  late final GeneratedColumn<String> estudianteId = GeneratedColumn<String>(
    'estudiante_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMovilidadMeta = const VerificationMeta(
    'tipoMovilidad',
  );
  @override
  late final GeneratedColumn<String> tipoMovilidad = GeneratedColumn<String>(
    'tipo_movilidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombresMeta = const VerificationMeta(
    'nombres',
  );
  @override
  late final GeneratedColumn<String> nombres = GeneratedColumn<String>(
    'nombres',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _apellidosMeta = const VerificationMeta(
    'apellidos',
  );
  @override
  late final GeneratedColumn<String> apellidos = GeneratedColumn<String>(
    'apellidos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _tipoDocumentoMeta = const VerificationMeta(
    'tipoDocumento',
  );
  @override
  late final GeneratedColumn<String> tipoDocumento = GeneratedColumn<String>(
    'tipo_documento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CC'),
  );
  static const VerificationMeta _numeroDocumentoMeta = const VerificationMeta(
    'numeroDocumento',
  );
  @override
  late final GeneratedColumn<String> numeroDocumento = GeneratedColumn<String>(
    'numero_documento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fechaNacimientoMeta = const VerificationMeta(
    'fechaNacimiento',
  );
  @override
  late final GeneratedColumn<DateTime> fechaNacimiento =
      GeneratedColumn<DateTime>(
        'fecha_nacimiento',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _emailInstitucionalMeta =
      const VerificationMeta('emailInstitucional');
  @override
  late final GeneratedColumn<String> emailInstitucional =
      GeneratedColumn<String>(
        'email_institucional',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _emailPersonalMeta = const VerificationMeta(
    'emailPersonal',
  );
  @override
  late final GeneratedColumn<String> emailPersonal = GeneratedColumn<String>(
    'email_personal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactoEmergenciaMeta =
      const VerificationMeta('contactoEmergencia');
  @override
  late final GeneratedColumn<String> contactoEmergencia =
      GeneratedColumn<String>(
        'contacto_emergencia',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _relacionContactoMeta = const VerificationMeta(
    'relacionContacto',
  );
  @override
  late final GeneratedColumn<String> relacionContacto = GeneratedColumn<String>(
    'relacion_contacto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _universidadActualMeta = const VerificationMeta(
    'universidadActual',
  );
  @override
  late final GeneratedColumn<String> universidadActual =
      GeneratedColumn<String>(
        'universidad_actual',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('Universidad de Medellin'),
      );
  static const VerificationMeta _facultadMeta = const VerificationMeta(
    'facultad',
  );
  @override
  late final GeneratedColumn<String> facultad = GeneratedColumn<String>(
    'facultad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _universidadDestinoIdMeta =
      const VerificationMeta('universidadDestinoId');
  @override
  late final GeneratedColumn<String> universidadDestinoId =
      GeneratedColumn<String>(
        'universidad_destino_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _universidadDestinoNombreMeta =
      const VerificationMeta('universidadDestinoNombre');
  @override
  late final GeneratedColumn<String> universidadDestinoNombre =
      GeneratedColumn<String>(
        'universidad_destino_nombre',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _paisDestinoMeta = const VerificationMeta(
    'paisDestino',
  );
  @override
  late final GeneratedColumn<String> paisDestino = GeneratedColumn<String>(
    'pais_destino',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ciudadDestinoMeta = const VerificationMeta(
    'ciudadDestino',
  );
  @override
  late final GeneratedColumn<String> ciudadDestino = GeneratedColumn<String>(
    'ciudad_destino',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _facultadDestinoMeta = const VerificationMeta(
    'facultadDestino',
  );
  @override
  late final GeneratedColumn<String> facultadDestino = GeneratedColumn<String>(
    'facultad_destino',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _areaEstudioMeta = const VerificationMeta(
    'areaEstudio',
  );
  @override
  late final GeneratedColumn<String> areaEstudio = GeneratedColumn<String>(
    'area_estudio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _programaAcademicoMeta = const VerificationMeta(
    'programaAcademico',
  );
  @override
  late final GeneratedColumn<String> programaAcademico =
      GeneratedColumn<String>(
        'programa_academico',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _semestreMeta = const VerificationMeta(
    'semestre',
  );
  @override
  late final GeneratedColumn<int> semestre = GeneratedColumn<int>(
    'semestre',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promedioAcumuladoMeta = const VerificationMeta(
    'promedioAcumulado',
  );
  @override
  late final GeneratedColumn<double> promedioAcumulado =
      GeneratedColumn<double>(
        'promedio_acumulado',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _nivelIdiomaMeta = const VerificationMeta(
    'nivelIdioma',
  );
  @override
  late final GeneratedColumn<String> nivelIdioma = GeneratedColumn<String>(
    'nivel_idioma',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _puntajeIdiomaMeta = const VerificationMeta(
    'puntajeIdioma',
  );
  @override
  late final GeneratedColumn<String> puntajeIdioma = GeneratedColumn<String>(
    'puntaje_idioma',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _semestreIntercambioMeta =
      const VerificationMeta('semestreIntercambio');
  @override
  late final GeneratedColumn<String> semestreIntercambio =
      GeneratedColumn<String>(
        'semestre_intercambio',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _fechaViajeMeta = const VerificationMeta(
    'fechaViaje',
  );
  @override
  late final GeneratedColumn<DateTime> fechaViaje = GeneratedColumn<DateTime>(
    'fecha_viaje',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaRegresoMeta = const VerificationMeta(
    'fechaRegreso',
  );
  @override
  late final GeneratedColumn<DateTime> fechaRegreso = GeneratedColumn<DateTime>(
    'fecha_regreso',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('borrador'),
  );
  static const VerificationMeta _bloqueadaMeta = const VerificationMeta(
    'bloqueada',
  );
  @override
  late final GeneratedColumn<bool> bloqueada = GeneratedColumn<bool>(
    'bloqueada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bloqueada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _fechaCreacionMeta = const VerificationMeta(
    'fechaCreacion',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>(
        'fecha_creacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fechaActualizacionMeta =
      const VerificationMeta('fechaActualizacion');
  @override
  late final GeneratedColumn<DateTime> fechaActualizacion =
      GeneratedColumn<DateTime>(
        'fecha_actualizacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    estudianteId,
    tipoMovilidad,
    nombres,
    apellidos,
    tipoDocumento,
    numeroDocumento,
    fechaNacimiento,
    emailInstitucional,
    emailPersonal,
    telefono,
    contactoEmergencia,
    relacionContacto,
    universidadActual,
    facultad,
    universidadDestinoId,
    universidadDestinoNombre,
    paisDestino,
    ciudadDestino,
    facultadDestino,
    areaEstudio,
    programaAcademico,
    semestre,
    promedioAcumulado,
    nivelIdioma,
    puntajeIdioma,
    semestreIntercambio,
    fechaViaje,
    fechaRegreso,
    estado,
    bloqueada,
    fechaCreacion,
    fechaActualizacion,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'solicitud_movilidad';
  @override
  VerificationContext validateIntegrity(
    Insertable<SolicitudMobilidadData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('estudiante_id')) {
      context.handle(
        _estudianteIdMeta,
        estudianteId.isAcceptableOrUnknown(
          data['estudiante_id']!,
          _estudianteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estudianteIdMeta);
    }
    if (data.containsKey('tipo_movilidad')) {
      context.handle(
        _tipoMovilidadMeta,
        tipoMovilidad.isAcceptableOrUnknown(
          data['tipo_movilidad']!,
          _tipoMovilidadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoMovilidadMeta);
    }
    if (data.containsKey('nombres')) {
      context.handle(
        _nombresMeta,
        nombres.isAcceptableOrUnknown(data['nombres']!, _nombresMeta),
      );
    }
    if (data.containsKey('apellidos')) {
      context.handle(
        _apellidosMeta,
        apellidos.isAcceptableOrUnknown(data['apellidos']!, _apellidosMeta),
      );
    }
    if (data.containsKey('tipo_documento')) {
      context.handle(
        _tipoDocumentoMeta,
        tipoDocumento.isAcceptableOrUnknown(
          data['tipo_documento']!,
          _tipoDocumentoMeta,
        ),
      );
    }
    if (data.containsKey('numero_documento')) {
      context.handle(
        _numeroDocumentoMeta,
        numeroDocumento.isAcceptableOrUnknown(
          data['numero_documento']!,
          _numeroDocumentoMeta,
        ),
      );
    }
    if (data.containsKey('fecha_nacimiento')) {
      context.handle(
        _fechaNacimientoMeta,
        fechaNacimiento.isAcceptableOrUnknown(
          data['fecha_nacimiento']!,
          _fechaNacimientoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaNacimientoMeta);
    }
    if (data.containsKey('email_institucional')) {
      context.handle(
        _emailInstitucionalMeta,
        emailInstitucional.isAcceptableOrUnknown(
          data['email_institucional']!,
          _emailInstitucionalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emailInstitucionalMeta);
    }
    if (data.containsKey('email_personal')) {
      context.handle(
        _emailPersonalMeta,
        emailPersonal.isAcceptableOrUnknown(
          data['email_personal']!,
          _emailPersonalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emailPersonalMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('contacto_emergencia')) {
      context.handle(
        _contactoEmergenciaMeta,
        contactoEmergencia.isAcceptableOrUnknown(
          data['contacto_emergencia']!,
          _contactoEmergenciaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactoEmergenciaMeta);
    }
    if (data.containsKey('relacion_contacto')) {
      context.handle(
        _relacionContactoMeta,
        relacionContacto.isAcceptableOrUnknown(
          data['relacion_contacto']!,
          _relacionContactoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relacionContactoMeta);
    }
    if (data.containsKey('universidad_actual')) {
      context.handle(
        _universidadActualMeta,
        universidadActual.isAcceptableOrUnknown(
          data['universidad_actual']!,
          _universidadActualMeta,
        ),
      );
    }
    if (data.containsKey('facultad')) {
      context.handle(
        _facultadMeta,
        facultad.isAcceptableOrUnknown(data['facultad']!, _facultadMeta),
      );
    }
    if (data.containsKey('universidad_destino_id')) {
      context.handle(
        _universidadDestinoIdMeta,
        universidadDestinoId.isAcceptableOrUnknown(
          data['universidad_destino_id']!,
          _universidadDestinoIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universidadDestinoIdMeta);
    }
    if (data.containsKey('universidad_destino_nombre')) {
      context.handle(
        _universidadDestinoNombreMeta,
        universidadDestinoNombre.isAcceptableOrUnknown(
          data['universidad_destino_nombre']!,
          _universidadDestinoNombreMeta,
        ),
      );
    }
    if (data.containsKey('pais_destino')) {
      context.handle(
        _paisDestinoMeta,
        paisDestino.isAcceptableOrUnknown(
          data['pais_destino']!,
          _paisDestinoMeta,
        ),
      );
    }
    if (data.containsKey('ciudad_destino')) {
      context.handle(
        _ciudadDestinoMeta,
        ciudadDestino.isAcceptableOrUnknown(
          data['ciudad_destino']!,
          _ciudadDestinoMeta,
        ),
      );
    }
    if (data.containsKey('facultad_destino')) {
      context.handle(
        _facultadDestinoMeta,
        facultadDestino.isAcceptableOrUnknown(
          data['facultad_destino']!,
          _facultadDestinoMeta,
        ),
      );
    }
    if (data.containsKey('area_estudio')) {
      context.handle(
        _areaEstudioMeta,
        areaEstudio.isAcceptableOrUnknown(
          data['area_estudio']!,
          _areaEstudioMeta,
        ),
      );
    }
    if (data.containsKey('programa_academico')) {
      context.handle(
        _programaAcademicoMeta,
        programaAcademico.isAcceptableOrUnknown(
          data['programa_academico']!,
          _programaAcademicoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_programaAcademicoMeta);
    }
    if (data.containsKey('semestre')) {
      context.handle(
        _semestreMeta,
        semestre.isAcceptableOrUnknown(data['semestre']!, _semestreMeta),
      );
    } else if (isInserting) {
      context.missing(_semestreMeta);
    }
    if (data.containsKey('promedio_acumulado')) {
      context.handle(
        _promedioAcumuladoMeta,
        promedioAcumulado.isAcceptableOrUnknown(
          data['promedio_acumulado']!,
          _promedioAcumuladoMeta,
        ),
      );
    }
    if (data.containsKey('nivel_idioma')) {
      context.handle(
        _nivelIdiomaMeta,
        nivelIdioma.isAcceptableOrUnknown(
          data['nivel_idioma']!,
          _nivelIdiomaMeta,
        ),
      );
    }
    if (data.containsKey('puntaje_idioma')) {
      context.handle(
        _puntajeIdiomaMeta,
        puntajeIdioma.isAcceptableOrUnknown(
          data['puntaje_idioma']!,
          _puntajeIdiomaMeta,
        ),
      );
    }
    if (data.containsKey('semestre_intercambio')) {
      context.handle(
        _semestreIntercambioMeta,
        semestreIntercambio.isAcceptableOrUnknown(
          data['semestre_intercambio']!,
          _semestreIntercambioMeta,
        ),
      );
    }
    if (data.containsKey('fecha_viaje')) {
      context.handle(
        _fechaViajeMeta,
        fechaViaje.isAcceptableOrUnknown(data['fecha_viaje']!, _fechaViajeMeta),
      );
    }
    if (data.containsKey('fecha_regreso')) {
      context.handle(
        _fechaRegresoMeta,
        fechaRegreso.isAcceptableOrUnknown(
          data['fecha_regreso']!,
          _fechaRegresoMeta,
        ),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('bloqueada')) {
      context.handle(
        _bloqueadaMeta,
        bloqueada.isAcceptableOrUnknown(data['bloqueada']!, _bloqueadaMeta),
      );
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
        _fechaCreacionMeta,
        fechaCreacion.isAcceptableOrUnknown(
          data['fecha_creacion']!,
          _fechaCreacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    if (data.containsKey('fecha_actualizacion')) {
      context.handle(
        _fechaActualizacionMeta,
        fechaActualizacion.isAcceptableOrUnknown(
          data['fecha_actualizacion']!,
          _fechaActualizacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaActualizacionMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SolicitudMobilidadData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SolicitudMobilidadData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      estudianteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estudiante_id'],
      )!,
      tipoMovilidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_movilidad'],
      )!,
      nombres: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombres'],
      )!,
      apellidos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellidos'],
      )!,
      tipoDocumento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_documento'],
      )!,
      numeroDocumento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_documento'],
      )!,
      fechaNacimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_nacimiento'],
      )!,
      emailInstitucional: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email_institucional'],
      )!,
      emailPersonal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email_personal'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      contactoEmergencia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contacto_emergencia'],
      )!,
      relacionContacto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relacion_contacto'],
      )!,
      universidadActual: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}universidad_actual'],
      )!,
      facultad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facultad'],
      )!,
      universidadDestinoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}universidad_destino_id'],
      )!,
      universidadDestinoNombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}universidad_destino_nombre'],
      )!,
      paisDestino: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pais_destino'],
      )!,
      ciudadDestino: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ciudad_destino'],
      )!,
      facultadDestino: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facultad_destino'],
      )!,
      areaEstudio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area_estudio'],
      )!,
      programaAcademico: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}programa_academico'],
      )!,
      semestre: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semestre'],
      )!,
      promedioAcumulado: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}promedio_acumulado'],
      )!,
      nivelIdioma: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nivel_idioma'],
      )!,
      puntajeIdioma: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puntaje_idioma'],
      )!,
      semestreIntercambio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}semestre_intercambio'],
      )!,
      fechaViaje: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_viaje'],
      ),
      fechaRegreso: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_regreso'],
      ),
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      bloqueada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bloqueada'],
      )!,
      fechaCreacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_creacion'],
      )!,
      fechaActualizacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_actualizacion'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $SolicitudMovilidadTable createAlias(String alias) {
    return $SolicitudMovilidadTable(attachedDatabase, alias);
  }
}

class SolicitudMobilidadData extends DataClass
    implements Insertable<SolicitudMobilidadData> {
  final String id;
  final String estudianteId;
  final String tipoMovilidad;
  final String nombres;
  final String apellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final DateTime fechaNacimiento;
  final String emailInstitucional;
  final String emailPersonal;
  final String telefono;
  final String contactoEmergencia;
  final String relacionContacto;
  final String universidadActual;
  final String facultad;
  final String universidadDestinoId;
  final String universidadDestinoNombre;
  final String paisDestino;
  final String ciudadDestino;
  final String facultadDestino;
  final String areaEstudio;
  final String programaAcademico;
  final int semestre;
  final double promedioAcumulado;
  final String nivelIdioma;
  final String puntajeIdioma;
  final String semestreIntercambio;
  final DateTime? fechaViaje;
  final DateTime? fechaRegreso;
  final String estado;
  final bool bloqueada;
  final DateTime fechaCreacion;
  final DateTime fechaActualizacion;
  final bool pendingSync;
  const SolicitudMobilidadData({
    required this.id,
    required this.estudianteId,
    required this.tipoMovilidad,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.fechaNacimiento,
    required this.emailInstitucional,
    required this.emailPersonal,
    required this.telefono,
    required this.contactoEmergencia,
    required this.relacionContacto,
    required this.universidadActual,
    required this.facultad,
    required this.universidadDestinoId,
    required this.universidadDestinoNombre,
    required this.paisDestino,
    required this.ciudadDestino,
    required this.facultadDestino,
    required this.areaEstudio,
    required this.programaAcademico,
    required this.semestre,
    required this.promedioAcumulado,
    required this.nivelIdioma,
    required this.puntajeIdioma,
    required this.semestreIntercambio,
    this.fechaViaje,
    this.fechaRegreso,
    required this.estado,
    required this.bloqueada,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['estudiante_id'] = Variable<String>(estudianteId);
    map['tipo_movilidad'] = Variable<String>(tipoMovilidad);
    map['nombres'] = Variable<String>(nombres);
    map['apellidos'] = Variable<String>(apellidos);
    map['tipo_documento'] = Variable<String>(tipoDocumento);
    map['numero_documento'] = Variable<String>(numeroDocumento);
    map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento);
    map['email_institucional'] = Variable<String>(emailInstitucional);
    map['email_personal'] = Variable<String>(emailPersonal);
    map['telefono'] = Variable<String>(telefono);
    map['contacto_emergencia'] = Variable<String>(contactoEmergencia);
    map['relacion_contacto'] = Variable<String>(relacionContacto);
    map['universidad_actual'] = Variable<String>(universidadActual);
    map['facultad'] = Variable<String>(facultad);
    map['universidad_destino_id'] = Variable<String>(universidadDestinoId);
    map['universidad_destino_nombre'] = Variable<String>(
      universidadDestinoNombre,
    );
    map['pais_destino'] = Variable<String>(paisDestino);
    map['ciudad_destino'] = Variable<String>(ciudadDestino);
    map['facultad_destino'] = Variable<String>(facultadDestino);
    map['area_estudio'] = Variable<String>(areaEstudio);
    map['programa_academico'] = Variable<String>(programaAcademico);
    map['semestre'] = Variable<int>(semestre);
    map['promedio_acumulado'] = Variable<double>(promedioAcumulado);
    map['nivel_idioma'] = Variable<String>(nivelIdioma);
    map['puntaje_idioma'] = Variable<String>(puntajeIdioma);
    map['semestre_intercambio'] = Variable<String>(semestreIntercambio);
    if (!nullToAbsent || fechaViaje != null) {
      map['fecha_viaje'] = Variable<DateTime>(fechaViaje);
    }
    if (!nullToAbsent || fechaRegreso != null) {
      map['fecha_regreso'] = Variable<DateTime>(fechaRegreso);
    }
    map['estado'] = Variable<String>(estado);
    map['bloqueada'] = Variable<bool>(bloqueada);
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    map['fecha_actualizacion'] = Variable<DateTime>(fechaActualizacion);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  SolicitudMovilidadCompanion toCompanion(bool nullToAbsent) {
    return SolicitudMovilidadCompanion(
      id: Value(id),
      estudianteId: Value(estudianteId),
      tipoMovilidad: Value(tipoMovilidad),
      nombres: Value(nombres),
      apellidos: Value(apellidos),
      tipoDocumento: Value(tipoDocumento),
      numeroDocumento: Value(numeroDocumento),
      fechaNacimiento: Value(fechaNacimiento),
      emailInstitucional: Value(emailInstitucional),
      emailPersonal: Value(emailPersonal),
      telefono: Value(telefono),
      contactoEmergencia: Value(contactoEmergencia),
      relacionContacto: Value(relacionContacto),
      universidadActual: Value(universidadActual),
      facultad: Value(facultad),
      universidadDestinoId: Value(universidadDestinoId),
      universidadDestinoNombre: Value(universidadDestinoNombre),
      paisDestino: Value(paisDestino),
      ciudadDestino: Value(ciudadDestino),
      facultadDestino: Value(facultadDestino),
      areaEstudio: Value(areaEstudio),
      programaAcademico: Value(programaAcademico),
      semestre: Value(semestre),
      promedioAcumulado: Value(promedioAcumulado),
      nivelIdioma: Value(nivelIdioma),
      puntajeIdioma: Value(puntajeIdioma),
      semestreIntercambio: Value(semestreIntercambio),
      fechaViaje: fechaViaje == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaViaje),
      fechaRegreso: fechaRegreso == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaRegreso),
      estado: Value(estado),
      bloqueada: Value(bloqueada),
      fechaCreacion: Value(fechaCreacion),
      fechaActualizacion: Value(fechaActualizacion),
      pendingSync: Value(pendingSync),
    );
  }

  factory SolicitudMobilidadData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SolicitudMobilidadData(
      id: serializer.fromJson<String>(json['id']),
      estudianteId: serializer.fromJson<String>(json['estudianteId']),
      tipoMovilidad: serializer.fromJson<String>(json['tipoMovilidad']),
      nombres: serializer.fromJson<String>(json['nombres']),
      apellidos: serializer.fromJson<String>(json['apellidos']),
      tipoDocumento: serializer.fromJson<String>(json['tipoDocumento']),
      numeroDocumento: serializer.fromJson<String>(json['numeroDocumento']),
      fechaNacimiento: serializer.fromJson<DateTime>(json['fechaNacimiento']),
      emailInstitucional: serializer.fromJson<String>(
        json['emailInstitucional'],
      ),
      emailPersonal: serializer.fromJson<String>(json['emailPersonal']),
      telefono: serializer.fromJson<String>(json['telefono']),
      contactoEmergencia: serializer.fromJson<String>(
        json['contactoEmergencia'],
      ),
      relacionContacto: serializer.fromJson<String>(json['relacionContacto']),
      universidadActual: serializer.fromJson<String>(json['universidadActual']),
      facultad: serializer.fromJson<String>(json['facultad']),
      universidadDestinoId: serializer.fromJson<String>(
        json['universidadDestinoId'],
      ),
      universidadDestinoNombre: serializer.fromJson<String>(
        json['universidadDestinoNombre'],
      ),
      paisDestino: serializer.fromJson<String>(json['paisDestino']),
      ciudadDestino: serializer.fromJson<String>(json['ciudadDestino']),
      facultadDestino: serializer.fromJson<String>(json['facultadDestino']),
      areaEstudio: serializer.fromJson<String>(json['areaEstudio']),
      programaAcademico: serializer.fromJson<String>(json['programaAcademico']),
      semestre: serializer.fromJson<int>(json['semestre']),
      promedioAcumulado: serializer.fromJson<double>(json['promedioAcumulado']),
      nivelIdioma: serializer.fromJson<String>(json['nivelIdioma']),
      puntajeIdioma: serializer.fromJson<String>(json['puntajeIdioma']),
      semestreIntercambio: serializer.fromJson<String>(
        json['semestreIntercambio'],
      ),
      fechaViaje: serializer.fromJson<DateTime?>(json['fechaViaje']),
      fechaRegreso: serializer.fromJson<DateTime?>(json['fechaRegreso']),
      estado: serializer.fromJson<String>(json['estado']),
      bloqueada: serializer.fromJson<bool>(json['bloqueada']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
      fechaActualizacion: serializer.fromJson<DateTime>(
        json['fechaActualizacion'],
      ),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'estudianteId': serializer.toJson<String>(estudianteId),
      'tipoMovilidad': serializer.toJson<String>(tipoMovilidad),
      'nombres': serializer.toJson<String>(nombres),
      'apellidos': serializer.toJson<String>(apellidos),
      'tipoDocumento': serializer.toJson<String>(tipoDocumento),
      'numeroDocumento': serializer.toJson<String>(numeroDocumento),
      'fechaNacimiento': serializer.toJson<DateTime>(fechaNacimiento),
      'emailInstitucional': serializer.toJson<String>(emailInstitucional),
      'emailPersonal': serializer.toJson<String>(emailPersonal),
      'telefono': serializer.toJson<String>(telefono),
      'contactoEmergencia': serializer.toJson<String>(contactoEmergencia),
      'relacionContacto': serializer.toJson<String>(relacionContacto),
      'universidadActual': serializer.toJson<String>(universidadActual),
      'facultad': serializer.toJson<String>(facultad),
      'universidadDestinoId': serializer.toJson<String>(universidadDestinoId),
      'universidadDestinoNombre': serializer.toJson<String>(
        universidadDestinoNombre,
      ),
      'paisDestino': serializer.toJson<String>(paisDestino),
      'ciudadDestino': serializer.toJson<String>(ciudadDestino),
      'facultadDestino': serializer.toJson<String>(facultadDestino),
      'areaEstudio': serializer.toJson<String>(areaEstudio),
      'programaAcademico': serializer.toJson<String>(programaAcademico),
      'semestre': serializer.toJson<int>(semestre),
      'promedioAcumulado': serializer.toJson<double>(promedioAcumulado),
      'nivelIdioma': serializer.toJson<String>(nivelIdioma),
      'puntajeIdioma': serializer.toJson<String>(puntajeIdioma),
      'semestreIntercambio': serializer.toJson<String>(semestreIntercambio),
      'fechaViaje': serializer.toJson<DateTime?>(fechaViaje),
      'fechaRegreso': serializer.toJson<DateTime?>(fechaRegreso),
      'estado': serializer.toJson<String>(estado),
      'bloqueada': serializer.toJson<bool>(bloqueada),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
      'fechaActualizacion': serializer.toJson<DateTime>(fechaActualizacion),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  SolicitudMobilidadData copyWith({
    String? id,
    String? estudianteId,
    String? tipoMovilidad,
    String? nombres,
    String? apellidos,
    String? tipoDocumento,
    String? numeroDocumento,
    DateTime? fechaNacimiento,
    String? emailInstitucional,
    String? emailPersonal,
    String? telefono,
    String? contactoEmergencia,
    String? relacionContacto,
    String? universidadActual,
    String? facultad,
    String? universidadDestinoId,
    String? universidadDestinoNombre,
    String? paisDestino,
    String? ciudadDestino,
    String? facultadDestino,
    String? areaEstudio,
    String? programaAcademico,
    int? semestre,
    double? promedioAcumulado,
    String? nivelIdioma,
    String? puntajeIdioma,
    String? semestreIntercambio,
    Value<DateTime?> fechaViaje = const Value.absent(),
    Value<DateTime?> fechaRegreso = const Value.absent(),
    String? estado,
    bool? bloqueada,
    DateTime? fechaCreacion,
    DateTime? fechaActualizacion,
    bool? pendingSync,
  }) => SolicitudMobilidadData(
    id: id ?? this.id,
    estudianteId: estudianteId ?? this.estudianteId,
    tipoMovilidad: tipoMovilidad ?? this.tipoMovilidad,
    nombres: nombres ?? this.nombres,
    apellidos: apellidos ?? this.apellidos,
    tipoDocumento: tipoDocumento ?? this.tipoDocumento,
    numeroDocumento: numeroDocumento ?? this.numeroDocumento,
    fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    emailInstitucional: emailInstitucional ?? this.emailInstitucional,
    emailPersonal: emailPersonal ?? this.emailPersonal,
    telefono: telefono ?? this.telefono,
    contactoEmergencia: contactoEmergencia ?? this.contactoEmergencia,
    relacionContacto: relacionContacto ?? this.relacionContacto,
    universidadActual: universidadActual ?? this.universidadActual,
    facultad: facultad ?? this.facultad,
    universidadDestinoId: universidadDestinoId ?? this.universidadDestinoId,
    universidadDestinoNombre:
        universidadDestinoNombre ?? this.universidadDestinoNombre,
    paisDestino: paisDestino ?? this.paisDestino,
    ciudadDestino: ciudadDestino ?? this.ciudadDestino,
    facultadDestino: facultadDestino ?? this.facultadDestino,
    areaEstudio: areaEstudio ?? this.areaEstudio,
    programaAcademico: programaAcademico ?? this.programaAcademico,
    semestre: semestre ?? this.semestre,
    promedioAcumulado: promedioAcumulado ?? this.promedioAcumulado,
    nivelIdioma: nivelIdioma ?? this.nivelIdioma,
    puntajeIdioma: puntajeIdioma ?? this.puntajeIdioma,
    semestreIntercambio: semestreIntercambio ?? this.semestreIntercambio,
    fechaViaje: fechaViaje.present ? fechaViaje.value : this.fechaViaje,
    fechaRegreso: fechaRegreso.present ? fechaRegreso.value : this.fechaRegreso,
    estado: estado ?? this.estado,
    bloqueada: bloqueada ?? this.bloqueada,
    fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  SolicitudMobilidadData copyWithCompanion(SolicitudMovilidadCompanion data) {
    return SolicitudMobilidadData(
      id: data.id.present ? data.id.value : this.id,
      estudianteId: data.estudianteId.present
          ? data.estudianteId.value
          : this.estudianteId,
      tipoMovilidad: data.tipoMovilidad.present
          ? data.tipoMovilidad.value
          : this.tipoMovilidad,
      nombres: data.nombres.present ? data.nombres.value : this.nombres,
      apellidos: data.apellidos.present ? data.apellidos.value : this.apellidos,
      tipoDocumento: data.tipoDocumento.present
          ? data.tipoDocumento.value
          : this.tipoDocumento,
      numeroDocumento: data.numeroDocumento.present
          ? data.numeroDocumento.value
          : this.numeroDocumento,
      fechaNacimiento: data.fechaNacimiento.present
          ? data.fechaNacimiento.value
          : this.fechaNacimiento,
      emailInstitucional: data.emailInstitucional.present
          ? data.emailInstitucional.value
          : this.emailInstitucional,
      emailPersonal: data.emailPersonal.present
          ? data.emailPersonal.value
          : this.emailPersonal,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      contactoEmergencia: data.contactoEmergencia.present
          ? data.contactoEmergencia.value
          : this.contactoEmergencia,
      relacionContacto: data.relacionContacto.present
          ? data.relacionContacto.value
          : this.relacionContacto,
      universidadActual: data.universidadActual.present
          ? data.universidadActual.value
          : this.universidadActual,
      facultad: data.facultad.present ? data.facultad.value : this.facultad,
      universidadDestinoId: data.universidadDestinoId.present
          ? data.universidadDestinoId.value
          : this.universidadDestinoId,
      universidadDestinoNombre: data.universidadDestinoNombre.present
          ? data.universidadDestinoNombre.value
          : this.universidadDestinoNombre,
      paisDestino: data.paisDestino.present
          ? data.paisDestino.value
          : this.paisDestino,
      ciudadDestino: data.ciudadDestino.present
          ? data.ciudadDestino.value
          : this.ciudadDestino,
      facultadDestino: data.facultadDestino.present
          ? data.facultadDestino.value
          : this.facultadDestino,
      areaEstudio: data.areaEstudio.present
          ? data.areaEstudio.value
          : this.areaEstudio,
      programaAcademico: data.programaAcademico.present
          ? data.programaAcademico.value
          : this.programaAcademico,
      semestre: data.semestre.present ? data.semestre.value : this.semestre,
      promedioAcumulado: data.promedioAcumulado.present
          ? data.promedioAcumulado.value
          : this.promedioAcumulado,
      nivelIdioma: data.nivelIdioma.present
          ? data.nivelIdioma.value
          : this.nivelIdioma,
      puntajeIdioma: data.puntajeIdioma.present
          ? data.puntajeIdioma.value
          : this.puntajeIdioma,
      semestreIntercambio: data.semestreIntercambio.present
          ? data.semestreIntercambio.value
          : this.semestreIntercambio,
      fechaViaje: data.fechaViaje.present
          ? data.fechaViaje.value
          : this.fechaViaje,
      fechaRegreso: data.fechaRegreso.present
          ? data.fechaRegreso.value
          : this.fechaRegreso,
      estado: data.estado.present ? data.estado.value : this.estado,
      bloqueada: data.bloqueada.present ? data.bloqueada.value : this.bloqueada,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
      fechaActualizacion: data.fechaActualizacion.present
          ? data.fechaActualizacion.value
          : this.fechaActualizacion,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SolicitudMobilidadData(')
          ..write('id: $id, ')
          ..write('estudianteId: $estudianteId, ')
          ..write('tipoMovilidad: $tipoMovilidad, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('tipoDocumento: $tipoDocumento, ')
          ..write('numeroDocumento: $numeroDocumento, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('emailInstitucional: $emailInstitucional, ')
          ..write('emailPersonal: $emailPersonal, ')
          ..write('telefono: $telefono, ')
          ..write('contactoEmergencia: $contactoEmergencia, ')
          ..write('relacionContacto: $relacionContacto, ')
          ..write('universidadActual: $universidadActual, ')
          ..write('facultad: $facultad, ')
          ..write('universidadDestinoId: $universidadDestinoId, ')
          ..write('universidadDestinoNombre: $universidadDestinoNombre, ')
          ..write('paisDestino: $paisDestino, ')
          ..write('ciudadDestino: $ciudadDestino, ')
          ..write('facultadDestino: $facultadDestino, ')
          ..write('areaEstudio: $areaEstudio, ')
          ..write('programaAcademico: $programaAcademico, ')
          ..write('semestre: $semestre, ')
          ..write('promedioAcumulado: $promedioAcumulado, ')
          ..write('nivelIdioma: $nivelIdioma, ')
          ..write('puntajeIdioma: $puntajeIdioma, ')
          ..write('semestreIntercambio: $semestreIntercambio, ')
          ..write('fechaViaje: $fechaViaje, ')
          ..write('fechaRegreso: $fechaRegreso, ')
          ..write('estado: $estado, ')
          ..write('bloqueada: $bloqueada, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('fechaActualizacion: $fechaActualizacion, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    estudianteId,
    tipoMovilidad,
    nombres,
    apellidos,
    tipoDocumento,
    numeroDocumento,
    fechaNacimiento,
    emailInstitucional,
    emailPersonal,
    telefono,
    contactoEmergencia,
    relacionContacto,
    universidadActual,
    facultad,
    universidadDestinoId,
    universidadDestinoNombre,
    paisDestino,
    ciudadDestino,
    facultadDestino,
    areaEstudio,
    programaAcademico,
    semestre,
    promedioAcumulado,
    nivelIdioma,
    puntajeIdioma,
    semestreIntercambio,
    fechaViaje,
    fechaRegreso,
    estado,
    bloqueada,
    fechaCreacion,
    fechaActualizacion,
    pendingSync,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SolicitudMobilidadData &&
          other.id == this.id &&
          other.estudianteId == this.estudianteId &&
          other.tipoMovilidad == this.tipoMovilidad &&
          other.nombres == this.nombres &&
          other.apellidos == this.apellidos &&
          other.tipoDocumento == this.tipoDocumento &&
          other.numeroDocumento == this.numeroDocumento &&
          other.fechaNacimiento == this.fechaNacimiento &&
          other.emailInstitucional == this.emailInstitucional &&
          other.emailPersonal == this.emailPersonal &&
          other.telefono == this.telefono &&
          other.contactoEmergencia == this.contactoEmergencia &&
          other.relacionContacto == this.relacionContacto &&
          other.universidadActual == this.universidadActual &&
          other.facultad == this.facultad &&
          other.universidadDestinoId == this.universidadDestinoId &&
          other.universidadDestinoNombre == this.universidadDestinoNombre &&
          other.paisDestino == this.paisDestino &&
          other.ciudadDestino == this.ciudadDestino &&
          other.facultadDestino == this.facultadDestino &&
          other.areaEstudio == this.areaEstudio &&
          other.programaAcademico == this.programaAcademico &&
          other.semestre == this.semestre &&
          other.promedioAcumulado == this.promedioAcumulado &&
          other.nivelIdioma == this.nivelIdioma &&
          other.puntajeIdioma == this.puntajeIdioma &&
          other.semestreIntercambio == this.semestreIntercambio &&
          other.fechaViaje == this.fechaViaje &&
          other.fechaRegreso == this.fechaRegreso &&
          other.estado == this.estado &&
          other.bloqueada == this.bloqueada &&
          other.fechaCreacion == this.fechaCreacion &&
          other.fechaActualizacion == this.fechaActualizacion &&
          other.pendingSync == this.pendingSync);
}

class SolicitudMovilidadCompanion
    extends UpdateCompanion<SolicitudMobilidadData> {
  final Value<String> id;
  final Value<String> estudianteId;
  final Value<String> tipoMovilidad;
  final Value<String> nombres;
  final Value<String> apellidos;
  final Value<String> tipoDocumento;
  final Value<String> numeroDocumento;
  final Value<DateTime> fechaNacimiento;
  final Value<String> emailInstitucional;
  final Value<String> emailPersonal;
  final Value<String> telefono;
  final Value<String> contactoEmergencia;
  final Value<String> relacionContacto;
  final Value<String> universidadActual;
  final Value<String> facultad;
  final Value<String> universidadDestinoId;
  final Value<String> universidadDestinoNombre;
  final Value<String> paisDestino;
  final Value<String> ciudadDestino;
  final Value<String> facultadDestino;
  final Value<String> areaEstudio;
  final Value<String> programaAcademico;
  final Value<int> semestre;
  final Value<double> promedioAcumulado;
  final Value<String> nivelIdioma;
  final Value<String> puntajeIdioma;
  final Value<String> semestreIntercambio;
  final Value<DateTime?> fechaViaje;
  final Value<DateTime?> fechaRegreso;
  final Value<String> estado;
  final Value<bool> bloqueada;
  final Value<DateTime> fechaCreacion;
  final Value<DateTime> fechaActualizacion;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const SolicitudMovilidadCompanion({
    this.id = const Value.absent(),
    this.estudianteId = const Value.absent(),
    this.tipoMovilidad = const Value.absent(),
    this.nombres = const Value.absent(),
    this.apellidos = const Value.absent(),
    this.tipoDocumento = const Value.absent(),
    this.numeroDocumento = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.emailInstitucional = const Value.absent(),
    this.emailPersonal = const Value.absent(),
    this.telefono = const Value.absent(),
    this.contactoEmergencia = const Value.absent(),
    this.relacionContacto = const Value.absent(),
    this.universidadActual = const Value.absent(),
    this.facultad = const Value.absent(),
    this.universidadDestinoId = const Value.absent(),
    this.universidadDestinoNombre = const Value.absent(),
    this.paisDestino = const Value.absent(),
    this.ciudadDestino = const Value.absent(),
    this.facultadDestino = const Value.absent(),
    this.areaEstudio = const Value.absent(),
    this.programaAcademico = const Value.absent(),
    this.semestre = const Value.absent(),
    this.promedioAcumulado = const Value.absent(),
    this.nivelIdioma = const Value.absent(),
    this.puntajeIdioma = const Value.absent(),
    this.semestreIntercambio = const Value.absent(),
    this.fechaViaje = const Value.absent(),
    this.fechaRegreso = const Value.absent(),
    this.estado = const Value.absent(),
    this.bloqueada = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.fechaActualizacion = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SolicitudMovilidadCompanion.insert({
    required String id,
    required String estudianteId,
    required String tipoMovilidad,
    this.nombres = const Value.absent(),
    this.apellidos = const Value.absent(),
    this.tipoDocumento = const Value.absent(),
    this.numeroDocumento = const Value.absent(),
    required DateTime fechaNacimiento,
    required String emailInstitucional,
    required String emailPersonal,
    required String telefono,
    required String contactoEmergencia,
    required String relacionContacto,
    this.universidadActual = const Value.absent(),
    this.facultad = const Value.absent(),
    required String universidadDestinoId,
    this.universidadDestinoNombre = const Value.absent(),
    this.paisDestino = const Value.absent(),
    this.ciudadDestino = const Value.absent(),
    this.facultadDestino = const Value.absent(),
    this.areaEstudio = const Value.absent(),
    required String programaAcademico,
    required int semestre,
    this.promedioAcumulado = const Value.absent(),
    this.nivelIdioma = const Value.absent(),
    this.puntajeIdioma = const Value.absent(),
    this.semestreIntercambio = const Value.absent(),
    this.fechaViaje = const Value.absent(),
    this.fechaRegreso = const Value.absent(),
    this.estado = const Value.absent(),
    this.bloqueada = const Value.absent(),
    required DateTime fechaCreacion,
    required DateTime fechaActualizacion,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       estudianteId = Value(estudianteId),
       tipoMovilidad = Value(tipoMovilidad),
       fechaNacimiento = Value(fechaNacimiento),
       emailInstitucional = Value(emailInstitucional),
       emailPersonal = Value(emailPersonal),
       telefono = Value(telefono),
       contactoEmergencia = Value(contactoEmergencia),
       relacionContacto = Value(relacionContacto),
       universidadDestinoId = Value(universidadDestinoId),
       programaAcademico = Value(programaAcademico),
       semestre = Value(semestre),
       fechaCreacion = Value(fechaCreacion),
       fechaActualizacion = Value(fechaActualizacion);
  static Insertable<SolicitudMobilidadData> custom({
    Expression<String>? id,
    Expression<String>? estudianteId,
    Expression<String>? tipoMovilidad,
    Expression<String>? nombres,
    Expression<String>? apellidos,
    Expression<String>? tipoDocumento,
    Expression<String>? numeroDocumento,
    Expression<DateTime>? fechaNacimiento,
    Expression<String>? emailInstitucional,
    Expression<String>? emailPersonal,
    Expression<String>? telefono,
    Expression<String>? contactoEmergencia,
    Expression<String>? relacionContacto,
    Expression<String>? universidadActual,
    Expression<String>? facultad,
    Expression<String>? universidadDestinoId,
    Expression<String>? universidadDestinoNombre,
    Expression<String>? paisDestino,
    Expression<String>? ciudadDestino,
    Expression<String>? facultadDestino,
    Expression<String>? areaEstudio,
    Expression<String>? programaAcademico,
    Expression<int>? semestre,
    Expression<double>? promedioAcumulado,
    Expression<String>? nivelIdioma,
    Expression<String>? puntajeIdioma,
    Expression<String>? semestreIntercambio,
    Expression<DateTime>? fechaViaje,
    Expression<DateTime>? fechaRegreso,
    Expression<String>? estado,
    Expression<bool>? bloqueada,
    Expression<DateTime>? fechaCreacion,
    Expression<DateTime>? fechaActualizacion,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estudianteId != null) 'estudiante_id': estudianteId,
      if (tipoMovilidad != null) 'tipo_movilidad': tipoMovilidad,
      if (nombres != null) 'nombres': nombres,
      if (apellidos != null) 'apellidos': apellidos,
      if (tipoDocumento != null) 'tipo_documento': tipoDocumento,
      if (numeroDocumento != null) 'numero_documento': numeroDocumento,
      if (fechaNacimiento != null) 'fecha_nacimiento': fechaNacimiento,
      if (emailInstitucional != null) 'email_institucional': emailInstitucional,
      if (emailPersonal != null) 'email_personal': emailPersonal,
      if (telefono != null) 'telefono': telefono,
      if (contactoEmergencia != null) 'contacto_emergencia': contactoEmergencia,
      if (relacionContacto != null) 'relacion_contacto': relacionContacto,
      if (universidadActual != null) 'universidad_actual': universidadActual,
      if (facultad != null) 'facultad': facultad,
      if (universidadDestinoId != null)
        'universidad_destino_id': universidadDestinoId,
      if (universidadDestinoNombre != null)
        'universidad_destino_nombre': universidadDestinoNombre,
      if (paisDestino != null) 'pais_destino': paisDestino,
      if (ciudadDestino != null) 'ciudad_destino': ciudadDestino,
      if (facultadDestino != null) 'facultad_destino': facultadDestino,
      if (areaEstudio != null) 'area_estudio': areaEstudio,
      if (programaAcademico != null) 'programa_academico': programaAcademico,
      if (semestre != null) 'semestre': semestre,
      if (promedioAcumulado != null) 'promedio_acumulado': promedioAcumulado,
      if (nivelIdioma != null) 'nivel_idioma': nivelIdioma,
      if (puntajeIdioma != null) 'puntaje_idioma': puntajeIdioma,
      if (semestreIntercambio != null)
        'semestre_intercambio': semestreIntercambio,
      if (fechaViaje != null) 'fecha_viaje': fechaViaje,
      if (fechaRegreso != null) 'fecha_regreso': fechaRegreso,
      if (estado != null) 'estado': estado,
      if (bloqueada != null) 'bloqueada': bloqueada,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (fechaActualizacion != null) 'fecha_actualizacion': fechaActualizacion,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SolicitudMovilidadCompanion copyWith({
    Value<String>? id,
    Value<String>? estudianteId,
    Value<String>? tipoMovilidad,
    Value<String>? nombres,
    Value<String>? apellidos,
    Value<String>? tipoDocumento,
    Value<String>? numeroDocumento,
    Value<DateTime>? fechaNacimiento,
    Value<String>? emailInstitucional,
    Value<String>? emailPersonal,
    Value<String>? telefono,
    Value<String>? contactoEmergencia,
    Value<String>? relacionContacto,
    Value<String>? universidadActual,
    Value<String>? facultad,
    Value<String>? universidadDestinoId,
    Value<String>? universidadDestinoNombre,
    Value<String>? paisDestino,
    Value<String>? ciudadDestino,
    Value<String>? facultadDestino,
    Value<String>? areaEstudio,
    Value<String>? programaAcademico,
    Value<int>? semestre,
    Value<double>? promedioAcumulado,
    Value<String>? nivelIdioma,
    Value<String>? puntajeIdioma,
    Value<String>? semestreIntercambio,
    Value<DateTime?>? fechaViaje,
    Value<DateTime?>? fechaRegreso,
    Value<String>? estado,
    Value<bool>? bloqueada,
    Value<DateTime>? fechaCreacion,
    Value<DateTime>? fechaActualizacion,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return SolicitudMovilidadCompanion(
      id: id ?? this.id,
      estudianteId: estudianteId ?? this.estudianteId,
      tipoMovilidad: tipoMovilidad ?? this.tipoMovilidad,
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      numeroDocumento: numeroDocumento ?? this.numeroDocumento,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      emailInstitucional: emailInstitucional ?? this.emailInstitucional,
      emailPersonal: emailPersonal ?? this.emailPersonal,
      telefono: telefono ?? this.telefono,
      contactoEmergencia: contactoEmergencia ?? this.contactoEmergencia,
      relacionContacto: relacionContacto ?? this.relacionContacto,
      universidadActual: universidadActual ?? this.universidadActual,
      facultad: facultad ?? this.facultad,
      universidadDestinoId: universidadDestinoId ?? this.universidadDestinoId,
      universidadDestinoNombre:
          universidadDestinoNombre ?? this.universidadDestinoNombre,
      paisDestino: paisDestino ?? this.paisDestino,
      ciudadDestino: ciudadDestino ?? this.ciudadDestino,
      facultadDestino: facultadDestino ?? this.facultadDestino,
      areaEstudio: areaEstudio ?? this.areaEstudio,
      programaAcademico: programaAcademico ?? this.programaAcademico,
      semestre: semestre ?? this.semestre,
      promedioAcumulado: promedioAcumulado ?? this.promedioAcumulado,
      nivelIdioma: nivelIdioma ?? this.nivelIdioma,
      puntajeIdioma: puntajeIdioma ?? this.puntajeIdioma,
      semestreIntercambio: semestreIntercambio ?? this.semestreIntercambio,
      fechaViaje: fechaViaje ?? this.fechaViaje,
      fechaRegreso: fechaRegreso ?? this.fechaRegreso,
      estado: estado ?? this.estado,
      bloqueada: bloqueada ?? this.bloqueada,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaActualizacion: fechaActualizacion ?? this.fechaActualizacion,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (estudianteId.present) {
      map['estudiante_id'] = Variable<String>(estudianteId.value);
    }
    if (tipoMovilidad.present) {
      map['tipo_movilidad'] = Variable<String>(tipoMovilidad.value);
    }
    if (nombres.present) {
      map['nombres'] = Variable<String>(nombres.value);
    }
    if (apellidos.present) {
      map['apellidos'] = Variable<String>(apellidos.value);
    }
    if (tipoDocumento.present) {
      map['tipo_documento'] = Variable<String>(tipoDocumento.value);
    }
    if (numeroDocumento.present) {
      map['numero_documento'] = Variable<String>(numeroDocumento.value);
    }
    if (fechaNacimiento.present) {
      map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento.value);
    }
    if (emailInstitucional.present) {
      map['email_institucional'] = Variable<String>(emailInstitucional.value);
    }
    if (emailPersonal.present) {
      map['email_personal'] = Variable<String>(emailPersonal.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (contactoEmergencia.present) {
      map['contacto_emergencia'] = Variable<String>(contactoEmergencia.value);
    }
    if (relacionContacto.present) {
      map['relacion_contacto'] = Variable<String>(relacionContacto.value);
    }
    if (universidadActual.present) {
      map['universidad_actual'] = Variable<String>(universidadActual.value);
    }
    if (facultad.present) {
      map['facultad'] = Variable<String>(facultad.value);
    }
    if (universidadDestinoId.present) {
      map['universidad_destino_id'] = Variable<String>(
        universidadDestinoId.value,
      );
    }
    if (universidadDestinoNombre.present) {
      map['universidad_destino_nombre'] = Variable<String>(
        universidadDestinoNombre.value,
      );
    }
    if (paisDestino.present) {
      map['pais_destino'] = Variable<String>(paisDestino.value);
    }
    if (ciudadDestino.present) {
      map['ciudad_destino'] = Variable<String>(ciudadDestino.value);
    }
    if (facultadDestino.present) {
      map['facultad_destino'] = Variable<String>(facultadDestino.value);
    }
    if (areaEstudio.present) {
      map['area_estudio'] = Variable<String>(areaEstudio.value);
    }
    if (programaAcademico.present) {
      map['programa_academico'] = Variable<String>(programaAcademico.value);
    }
    if (semestre.present) {
      map['semestre'] = Variable<int>(semestre.value);
    }
    if (promedioAcumulado.present) {
      map['promedio_acumulado'] = Variable<double>(promedioAcumulado.value);
    }
    if (nivelIdioma.present) {
      map['nivel_idioma'] = Variable<String>(nivelIdioma.value);
    }
    if (puntajeIdioma.present) {
      map['puntaje_idioma'] = Variable<String>(puntajeIdioma.value);
    }
    if (semestreIntercambio.present) {
      map['semestre_intercambio'] = Variable<String>(semestreIntercambio.value);
    }
    if (fechaViaje.present) {
      map['fecha_viaje'] = Variable<DateTime>(fechaViaje.value);
    }
    if (fechaRegreso.present) {
      map['fecha_regreso'] = Variable<DateTime>(fechaRegreso.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (bloqueada.present) {
      map['bloqueada'] = Variable<bool>(bloqueada.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    if (fechaActualizacion.present) {
      map['fecha_actualizacion'] = Variable<DateTime>(fechaActualizacion.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SolicitudMovilidadCompanion(')
          ..write('id: $id, ')
          ..write('estudianteId: $estudianteId, ')
          ..write('tipoMovilidad: $tipoMovilidad, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('tipoDocumento: $tipoDocumento, ')
          ..write('numeroDocumento: $numeroDocumento, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('emailInstitucional: $emailInstitucional, ')
          ..write('emailPersonal: $emailPersonal, ')
          ..write('telefono: $telefono, ')
          ..write('contactoEmergencia: $contactoEmergencia, ')
          ..write('relacionContacto: $relacionContacto, ')
          ..write('universidadActual: $universidadActual, ')
          ..write('facultad: $facultad, ')
          ..write('universidadDestinoId: $universidadDestinoId, ')
          ..write('universidadDestinoNombre: $universidadDestinoNombre, ')
          ..write('paisDestino: $paisDestino, ')
          ..write('ciudadDestino: $ciudadDestino, ')
          ..write('facultadDestino: $facultadDestino, ')
          ..write('areaEstudio: $areaEstudio, ')
          ..write('programaAcademico: $programaAcademico, ')
          ..write('semestre: $semestre, ')
          ..write('promedioAcumulado: $promedioAcumulado, ')
          ..write('nivelIdioma: $nivelIdioma, ')
          ..write('puntajeIdioma: $puntajeIdioma, ')
          ..write('semestreIntercambio: $semestreIntercambio, ')
          ..write('fechaViaje: $fechaViaje, ')
          ..write('fechaRegreso: $fechaRegreso, ')
          ..write('estado: $estado, ')
          ..write('bloqueada: $bloqueada, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('fechaActualizacion: $fechaActualizacion, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UniversidadDestinoTable extends UniversidadDestino
    with TableInfo<$UniversidadDestinoTable, UniversidadDestinoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UniversidadDestinoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paisMeta = const VerificationMeta('pais');
  @override
  late final GeneratedColumn<String> pais = GeneratedColumn<String>(
    'pais',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ciudadMeta = const VerificationMeta('ciudad');
  @override
  late final GeneratedColumn<String> ciudad = GeneratedColumn<String>(
    'ciudad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMovilidadMeta = const VerificationMeta(
    'tipoMovilidad',
  );
  @override
  late final GeneratedColumn<String> tipoMovilidad = GeneratedColumn<String>(
    'tipo_movilidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _convenioActivoMeta = const VerificationMeta(
    'convenioActivo',
  );
  @override
  late final GeneratedColumn<bool> convenioActivo = GeneratedColumn<bool>(
    'convenio_activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("convenio_activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    pais,
    ciudad,
    tipoMovilidad,
    convenioActivo,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'universidad_destino';
  @override
  VerificationContext validateIntegrity(
    Insertable<UniversidadDestinoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('pais')) {
      context.handle(
        _paisMeta,
        pais.isAcceptableOrUnknown(data['pais']!, _paisMeta),
      );
    } else if (isInserting) {
      context.missing(_paisMeta);
    }
    if (data.containsKey('ciudad')) {
      context.handle(
        _ciudadMeta,
        ciudad.isAcceptableOrUnknown(data['ciudad']!, _ciudadMeta),
      );
    } else if (isInserting) {
      context.missing(_ciudadMeta);
    }
    if (data.containsKey('tipo_movilidad')) {
      context.handle(
        _tipoMovilidadMeta,
        tipoMovilidad.isAcceptableOrUnknown(
          data['tipo_movilidad']!,
          _tipoMovilidadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoMovilidadMeta);
    }
    if (data.containsKey('convenio_activo')) {
      context.handle(
        _convenioActivoMeta,
        convenioActivo.isAcceptableOrUnknown(
          data['convenio_activo']!,
          _convenioActivoMeta,
        ),
      );
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UniversidadDestinoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UniversidadDestinoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      pais: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pais'],
      )!,
      ciudad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ciudad'],
      )!,
      tipoMovilidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_movilidad'],
      )!,
      convenioActivo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}convenio_activo'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $UniversidadDestinoTable createAlias(String alias) {
    return $UniversidadDestinoTable(attachedDatabase, alias);
  }
}

class UniversidadDestinoData extends DataClass
    implements Insertable<UniversidadDestinoData> {
  final String id;
  final String nombre;
  final String pais;
  final String ciudad;
  final String tipoMovilidad;
  final bool convenioActivo;
  final bool pendingSync;
  const UniversidadDestinoData({
    required this.id,
    required this.nombre,
    required this.pais,
    required this.ciudad,
    required this.tipoMovilidad,
    required this.convenioActivo,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['pais'] = Variable<String>(pais);
    map['ciudad'] = Variable<String>(ciudad);
    map['tipo_movilidad'] = Variable<String>(tipoMovilidad);
    map['convenio_activo'] = Variable<bool>(convenioActivo);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  UniversidadDestinoCompanion toCompanion(bool nullToAbsent) {
    return UniversidadDestinoCompanion(
      id: Value(id),
      nombre: Value(nombre),
      pais: Value(pais),
      ciudad: Value(ciudad),
      tipoMovilidad: Value(tipoMovilidad),
      convenioActivo: Value(convenioActivo),
      pendingSync: Value(pendingSync),
    );
  }

  factory UniversidadDestinoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UniversidadDestinoData(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      pais: serializer.fromJson<String>(json['pais']),
      ciudad: serializer.fromJson<String>(json['ciudad']),
      tipoMovilidad: serializer.fromJson<String>(json['tipoMovilidad']),
      convenioActivo: serializer.fromJson<bool>(json['convenioActivo']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'pais': serializer.toJson<String>(pais),
      'ciudad': serializer.toJson<String>(ciudad),
      'tipoMovilidad': serializer.toJson<String>(tipoMovilidad),
      'convenioActivo': serializer.toJson<bool>(convenioActivo),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  UniversidadDestinoData copyWith({
    String? id,
    String? nombre,
    String? pais,
    String? ciudad,
    String? tipoMovilidad,
    bool? convenioActivo,
    bool? pendingSync,
  }) => UniversidadDestinoData(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    pais: pais ?? this.pais,
    ciudad: ciudad ?? this.ciudad,
    tipoMovilidad: tipoMovilidad ?? this.tipoMovilidad,
    convenioActivo: convenioActivo ?? this.convenioActivo,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  UniversidadDestinoData copyWithCompanion(UniversidadDestinoCompanion data) {
    return UniversidadDestinoData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      pais: data.pais.present ? data.pais.value : this.pais,
      ciudad: data.ciudad.present ? data.ciudad.value : this.ciudad,
      tipoMovilidad: data.tipoMovilidad.present
          ? data.tipoMovilidad.value
          : this.tipoMovilidad,
      convenioActivo: data.convenioActivo.present
          ? data.convenioActivo.value
          : this.convenioActivo,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UniversidadDestinoData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('pais: $pais, ')
          ..write('ciudad: $ciudad, ')
          ..write('tipoMovilidad: $tipoMovilidad, ')
          ..write('convenioActivo: $convenioActivo, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    pais,
    ciudad,
    tipoMovilidad,
    convenioActivo,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UniversidadDestinoData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.pais == this.pais &&
          other.ciudad == this.ciudad &&
          other.tipoMovilidad == this.tipoMovilidad &&
          other.convenioActivo == this.convenioActivo &&
          other.pendingSync == this.pendingSync);
}

class UniversidadDestinoCompanion
    extends UpdateCompanion<UniversidadDestinoData> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> pais;
  final Value<String> ciudad;
  final Value<String> tipoMovilidad;
  final Value<bool> convenioActivo;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const UniversidadDestinoCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.pais = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.tipoMovilidad = const Value.absent(),
    this.convenioActivo = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UniversidadDestinoCompanion.insert({
    required String id,
    required String nombre,
    required String pais,
    required String ciudad,
    required String tipoMovilidad,
    this.convenioActivo = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       pais = Value(pais),
       ciudad = Value(ciudad),
       tipoMovilidad = Value(tipoMovilidad);
  static Insertable<UniversidadDestinoData> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? pais,
    Expression<String>? ciudad,
    Expression<String>? tipoMovilidad,
    Expression<bool>? convenioActivo,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (pais != null) 'pais': pais,
      if (ciudad != null) 'ciudad': ciudad,
      if (tipoMovilidad != null) 'tipo_movilidad': tipoMovilidad,
      if (convenioActivo != null) 'convenio_activo': convenioActivo,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UniversidadDestinoCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String>? pais,
    Value<String>? ciudad,
    Value<String>? tipoMovilidad,
    Value<bool>? convenioActivo,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return UniversidadDestinoCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      pais: pais ?? this.pais,
      ciudad: ciudad ?? this.ciudad,
      tipoMovilidad: tipoMovilidad ?? this.tipoMovilidad,
      convenioActivo: convenioActivo ?? this.convenioActivo,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (pais.present) {
      map['pais'] = Variable<String>(pais.value);
    }
    if (ciudad.present) {
      map['ciudad'] = Variable<String>(ciudad.value);
    }
    if (tipoMovilidad.present) {
      map['tipo_movilidad'] = Variable<String>(tipoMovilidad.value);
    }
    if (convenioActivo.present) {
      map['convenio_activo'] = Variable<bool>(convenioActivo.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UniversidadDestinoCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('pais: $pais, ')
          ..write('ciudad: $ciudad, ')
          ..write('tipoMovilidad: $tipoMovilidad, ')
          ..write('convenioActivo: $convenioActivo, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentoTable extends Documento
    with TableInfo<$DocumentoTable, DocumentoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _solicitudIdMeta = const VerificationMeta(
    'solicitudId',
  );
  @override
  late final GeneratedColumn<String> solicitudId = GeneratedColumn<String>(
    'solicitud_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoDocumentoMeta = const VerificationMeta(
    'tipoDocumento',
  );
  @override
  late final GeneratedColumn<String> tipoDocumento = GeneratedColumn<String>(
    'tipo_documento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreArchivoMeta = const VerificationMeta(
    'nombreArchivo',
  );
  @override
  late final GeneratedColumn<String> nombreArchivo = GeneratedColumn<String>(
    'nombre_archivo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pendiente'),
  );
  static const VerificationMeta _fechaSubidaMeta = const VerificationMeta(
    'fechaSubida',
  );
  @override
  late final GeneratedColumn<DateTime> fechaSubida = GeneratedColumn<DateTime>(
    'fecha_subida',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    solicitudId,
    tipoDocumento,
    nombreArchivo,
    estado,
    fechaSubida,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documento';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('solicitud_id')) {
      context.handle(
        _solicitudIdMeta,
        solicitudId.isAcceptableOrUnknown(
          data['solicitud_id']!,
          _solicitudIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_solicitudIdMeta);
    }
    if (data.containsKey('tipo_documento')) {
      context.handle(
        _tipoDocumentoMeta,
        tipoDocumento.isAcceptableOrUnknown(
          data['tipo_documento']!,
          _tipoDocumentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoDocumentoMeta);
    }
    if (data.containsKey('nombre_archivo')) {
      context.handle(
        _nombreArchivoMeta,
        nombreArchivo.isAcceptableOrUnknown(
          data['nombre_archivo']!,
          _nombreArchivoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreArchivoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('fecha_subida')) {
      context.handle(
        _fechaSubidaMeta,
        fechaSubida.isAcceptableOrUnknown(
          data['fecha_subida']!,
          _fechaSubidaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaSubidaMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      solicitudId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solicitud_id'],
      )!,
      tipoDocumento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_documento'],
      )!,
      nombreArchivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_archivo'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      fechaSubida: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_subida'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $DocumentoTable createAlias(String alias) {
    return $DocumentoTable(attachedDatabase, alias);
  }
}

class DocumentoData extends DataClass implements Insertable<DocumentoData> {
  final String id;
  final String solicitudId;
  final String tipoDocumento;
  final String nombreArchivo;
  final String estado;
  final DateTime fechaSubida;
  final bool pendingSync;
  const DocumentoData({
    required this.id,
    required this.solicitudId,
    required this.tipoDocumento,
    required this.nombreArchivo,
    required this.estado,
    required this.fechaSubida,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['solicitud_id'] = Variable<String>(solicitudId);
    map['tipo_documento'] = Variable<String>(tipoDocumento);
    map['nombre_archivo'] = Variable<String>(nombreArchivo);
    map['estado'] = Variable<String>(estado);
    map['fecha_subida'] = Variable<DateTime>(fechaSubida);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  DocumentoCompanion toCompanion(bool nullToAbsent) {
    return DocumentoCompanion(
      id: Value(id),
      solicitudId: Value(solicitudId),
      tipoDocumento: Value(tipoDocumento),
      nombreArchivo: Value(nombreArchivo),
      estado: Value(estado),
      fechaSubida: Value(fechaSubida),
      pendingSync: Value(pendingSync),
    );
  }

  factory DocumentoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentoData(
      id: serializer.fromJson<String>(json['id']),
      solicitudId: serializer.fromJson<String>(json['solicitudId']),
      tipoDocumento: serializer.fromJson<String>(json['tipoDocumento']),
      nombreArchivo: serializer.fromJson<String>(json['nombreArchivo']),
      estado: serializer.fromJson<String>(json['estado']),
      fechaSubida: serializer.fromJson<DateTime>(json['fechaSubida']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'solicitudId': serializer.toJson<String>(solicitudId),
      'tipoDocumento': serializer.toJson<String>(tipoDocumento),
      'nombreArchivo': serializer.toJson<String>(nombreArchivo),
      'estado': serializer.toJson<String>(estado),
      'fechaSubida': serializer.toJson<DateTime>(fechaSubida),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  DocumentoData copyWith({
    String? id,
    String? solicitudId,
    String? tipoDocumento,
    String? nombreArchivo,
    String? estado,
    DateTime? fechaSubida,
    bool? pendingSync,
  }) => DocumentoData(
    id: id ?? this.id,
    solicitudId: solicitudId ?? this.solicitudId,
    tipoDocumento: tipoDocumento ?? this.tipoDocumento,
    nombreArchivo: nombreArchivo ?? this.nombreArchivo,
    estado: estado ?? this.estado,
    fechaSubida: fechaSubida ?? this.fechaSubida,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  DocumentoData copyWithCompanion(DocumentoCompanion data) {
    return DocumentoData(
      id: data.id.present ? data.id.value : this.id,
      solicitudId: data.solicitudId.present
          ? data.solicitudId.value
          : this.solicitudId,
      tipoDocumento: data.tipoDocumento.present
          ? data.tipoDocumento.value
          : this.tipoDocumento,
      nombreArchivo: data.nombreArchivo.present
          ? data.nombreArchivo.value
          : this.nombreArchivo,
      estado: data.estado.present ? data.estado.value : this.estado,
      fechaSubida: data.fechaSubida.present
          ? data.fechaSubida.value
          : this.fechaSubida,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentoData(')
          ..write('id: $id, ')
          ..write('solicitudId: $solicitudId, ')
          ..write('tipoDocumento: $tipoDocumento, ')
          ..write('nombreArchivo: $nombreArchivo, ')
          ..write('estado: $estado, ')
          ..write('fechaSubida: $fechaSubida, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    solicitudId,
    tipoDocumento,
    nombreArchivo,
    estado,
    fechaSubida,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentoData &&
          other.id == this.id &&
          other.solicitudId == this.solicitudId &&
          other.tipoDocumento == this.tipoDocumento &&
          other.nombreArchivo == this.nombreArchivo &&
          other.estado == this.estado &&
          other.fechaSubida == this.fechaSubida &&
          other.pendingSync == this.pendingSync);
}

class DocumentoCompanion extends UpdateCompanion<DocumentoData> {
  final Value<String> id;
  final Value<String> solicitudId;
  final Value<String> tipoDocumento;
  final Value<String> nombreArchivo;
  final Value<String> estado;
  final Value<DateTime> fechaSubida;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const DocumentoCompanion({
    this.id = const Value.absent(),
    this.solicitudId = const Value.absent(),
    this.tipoDocumento = const Value.absent(),
    this.nombreArchivo = const Value.absent(),
    this.estado = const Value.absent(),
    this.fechaSubida = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentoCompanion.insert({
    required String id,
    required String solicitudId,
    required String tipoDocumento,
    required String nombreArchivo,
    this.estado = const Value.absent(),
    required DateTime fechaSubida,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       solicitudId = Value(solicitudId),
       tipoDocumento = Value(tipoDocumento),
       nombreArchivo = Value(nombreArchivo),
       fechaSubida = Value(fechaSubida);
  static Insertable<DocumentoData> custom({
    Expression<String>? id,
    Expression<String>? solicitudId,
    Expression<String>? tipoDocumento,
    Expression<String>? nombreArchivo,
    Expression<String>? estado,
    Expression<DateTime>? fechaSubida,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (solicitudId != null) 'solicitud_id': solicitudId,
      if (tipoDocumento != null) 'tipo_documento': tipoDocumento,
      if (nombreArchivo != null) 'nombre_archivo': nombreArchivo,
      if (estado != null) 'estado': estado,
      if (fechaSubida != null) 'fecha_subida': fechaSubida,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentoCompanion copyWith({
    Value<String>? id,
    Value<String>? solicitudId,
    Value<String>? tipoDocumento,
    Value<String>? nombreArchivo,
    Value<String>? estado,
    Value<DateTime>? fechaSubida,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return DocumentoCompanion(
      id: id ?? this.id,
      solicitudId: solicitudId ?? this.solicitudId,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      nombreArchivo: nombreArchivo ?? this.nombreArchivo,
      estado: estado ?? this.estado,
      fechaSubida: fechaSubida ?? this.fechaSubida,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (solicitudId.present) {
      map['solicitud_id'] = Variable<String>(solicitudId.value);
    }
    if (tipoDocumento.present) {
      map['tipo_documento'] = Variable<String>(tipoDocumento.value);
    }
    if (nombreArchivo.present) {
      map['nombre_archivo'] = Variable<String>(nombreArchivo.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (fechaSubida.present) {
      map['fecha_subida'] = Variable<DateTime>(fechaSubida.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentoCompanion(')
          ..write('id: $id, ')
          ..write('solicitudId: $solicitudId, ')
          ..write('tipoDocumento: $tipoDocumento, ')
          ..write('nombreArchivo: $nombreArchivo, ')
          ..write('estado: $estado, ')
          ..write('fechaSubida: $fechaSubida, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AprobacionTable extends Aprobacion
    with TableInfo<$AprobacionTable, AprobacionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AprobacionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _solicitudIdMeta = const VerificationMeta(
    'solicitudId',
  );
  @override
  late final GeneratedColumn<String> solicitudId = GeneratedColumn<String>(
    'solicitud_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coordinadorIdMeta = const VerificationMeta(
    'coordinadorId',
  );
  @override
  late final GeneratedColumn<String> coordinadorId = GeneratedColumn<String>(
    'coordinador_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decisionMeta = const VerificationMeta(
    'decision',
  );
  @override
  late final GeneratedColumn<String> decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _comentarioMeta = const VerificationMeta(
    'comentario',
  );
  @override
  late final GeneratedColumn<String> comentario = GeneratedColumn<String>(
    'comentario',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaDecisionMeta = const VerificationMeta(
    'fechaDecision',
  );
  @override
  late final GeneratedColumn<DateTime> fechaDecision =
      GeneratedColumn<DateTime>(
        'fecha_decision',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    solicitudId,
    coordinadorId,
    usuarioId,
    decision,
    comentario,
    fechaDecision,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aprobacion';
  @override
  VerificationContext validateIntegrity(
    Insertable<AprobacionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('solicitud_id')) {
      context.handle(
        _solicitudIdMeta,
        solicitudId.isAcceptableOrUnknown(
          data['solicitud_id']!,
          _solicitudIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_solicitudIdMeta);
    }
    if (data.containsKey('coordinador_id')) {
      context.handle(
        _coordinadorIdMeta,
        coordinadorId.isAcceptableOrUnknown(
          data['coordinador_id']!,
          _coordinadorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coordinadorIdMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('decision')) {
      context.handle(
        _decisionMeta,
        decision.isAcceptableOrUnknown(data['decision']!, _decisionMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionMeta);
    }
    if (data.containsKey('comentario')) {
      context.handle(
        _comentarioMeta,
        comentario.isAcceptableOrUnknown(data['comentario']!, _comentarioMeta),
      );
    } else if (isInserting) {
      context.missing(_comentarioMeta);
    }
    if (data.containsKey('fecha_decision')) {
      context.handle(
        _fechaDecisionMeta,
        fechaDecision.isAcceptableOrUnknown(
          data['fecha_decision']!,
          _fechaDecisionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaDecisionMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AprobacionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AprobacionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      solicitudId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solicitud_id'],
      )!,
      coordinadorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coordinador_id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      decision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision'],
      )!,
      comentario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comentario'],
      )!,
      fechaDecision: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_decision'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $AprobacionTable createAlias(String alias) {
    return $AprobacionTable(attachedDatabase, alias);
  }
}

class AprobacionData extends DataClass implements Insertable<AprobacionData> {
  final String id;
  final String solicitudId;
  final String coordinadorId;
  final String usuarioId;
  final String decision;
  final String comentario;
  final DateTime fechaDecision;
  final bool pendingSync;
  const AprobacionData({
    required this.id,
    required this.solicitudId,
    required this.coordinadorId,
    required this.usuarioId,
    required this.decision,
    required this.comentario,
    required this.fechaDecision,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['solicitud_id'] = Variable<String>(solicitudId);
    map['coordinador_id'] = Variable<String>(coordinadorId);
    map['usuario_id'] = Variable<String>(usuarioId);
    map['decision'] = Variable<String>(decision);
    map['comentario'] = Variable<String>(comentario);
    map['fecha_decision'] = Variable<DateTime>(fechaDecision);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  AprobacionCompanion toCompanion(bool nullToAbsent) {
    return AprobacionCompanion(
      id: Value(id),
      solicitudId: Value(solicitudId),
      coordinadorId: Value(coordinadorId),
      usuarioId: Value(usuarioId),
      decision: Value(decision),
      comentario: Value(comentario),
      fechaDecision: Value(fechaDecision),
      pendingSync: Value(pendingSync),
    );
  }

  factory AprobacionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AprobacionData(
      id: serializer.fromJson<String>(json['id']),
      solicitudId: serializer.fromJson<String>(json['solicitudId']),
      coordinadorId: serializer.fromJson<String>(json['coordinadorId']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      decision: serializer.fromJson<String>(json['decision']),
      comentario: serializer.fromJson<String>(json['comentario']),
      fechaDecision: serializer.fromJson<DateTime>(json['fechaDecision']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'solicitudId': serializer.toJson<String>(solicitudId),
      'coordinadorId': serializer.toJson<String>(coordinadorId),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'decision': serializer.toJson<String>(decision),
      'comentario': serializer.toJson<String>(comentario),
      'fechaDecision': serializer.toJson<DateTime>(fechaDecision),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  AprobacionData copyWith({
    String? id,
    String? solicitudId,
    String? coordinadorId,
    String? usuarioId,
    String? decision,
    String? comentario,
    DateTime? fechaDecision,
    bool? pendingSync,
  }) => AprobacionData(
    id: id ?? this.id,
    solicitudId: solicitudId ?? this.solicitudId,
    coordinadorId: coordinadorId ?? this.coordinadorId,
    usuarioId: usuarioId ?? this.usuarioId,
    decision: decision ?? this.decision,
    comentario: comentario ?? this.comentario,
    fechaDecision: fechaDecision ?? this.fechaDecision,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  AprobacionData copyWithCompanion(AprobacionCompanion data) {
    return AprobacionData(
      id: data.id.present ? data.id.value : this.id,
      solicitudId: data.solicitudId.present
          ? data.solicitudId.value
          : this.solicitudId,
      coordinadorId: data.coordinadorId.present
          ? data.coordinadorId.value
          : this.coordinadorId,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      decision: data.decision.present ? data.decision.value : this.decision,
      comentario: data.comentario.present
          ? data.comentario.value
          : this.comentario,
      fechaDecision: data.fechaDecision.present
          ? data.fechaDecision.value
          : this.fechaDecision,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AprobacionData(')
          ..write('id: $id, ')
          ..write('solicitudId: $solicitudId, ')
          ..write('coordinadorId: $coordinadorId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('decision: $decision, ')
          ..write('comentario: $comentario, ')
          ..write('fechaDecision: $fechaDecision, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    solicitudId,
    coordinadorId,
    usuarioId,
    decision,
    comentario,
    fechaDecision,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AprobacionData &&
          other.id == this.id &&
          other.solicitudId == this.solicitudId &&
          other.coordinadorId == this.coordinadorId &&
          other.usuarioId == this.usuarioId &&
          other.decision == this.decision &&
          other.comentario == this.comentario &&
          other.fechaDecision == this.fechaDecision &&
          other.pendingSync == this.pendingSync);
}

class AprobacionCompanion extends UpdateCompanion<AprobacionData> {
  final Value<String> id;
  final Value<String> solicitudId;
  final Value<String> coordinadorId;
  final Value<String> usuarioId;
  final Value<String> decision;
  final Value<String> comentario;
  final Value<DateTime> fechaDecision;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const AprobacionCompanion({
    this.id = const Value.absent(),
    this.solicitudId = const Value.absent(),
    this.coordinadorId = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.decision = const Value.absent(),
    this.comentario = const Value.absent(),
    this.fechaDecision = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AprobacionCompanion.insert({
    required String id,
    required String solicitudId,
    required String coordinadorId,
    required String usuarioId,
    required String decision,
    required String comentario,
    required DateTime fechaDecision,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       solicitudId = Value(solicitudId),
       coordinadorId = Value(coordinadorId),
       usuarioId = Value(usuarioId),
       decision = Value(decision),
       comentario = Value(comentario),
       fechaDecision = Value(fechaDecision);
  static Insertable<AprobacionData> custom({
    Expression<String>? id,
    Expression<String>? solicitudId,
    Expression<String>? coordinadorId,
    Expression<String>? usuarioId,
    Expression<String>? decision,
    Expression<String>? comentario,
    Expression<DateTime>? fechaDecision,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (solicitudId != null) 'solicitud_id': solicitudId,
      if (coordinadorId != null) 'coordinador_id': coordinadorId,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (decision != null) 'decision': decision,
      if (comentario != null) 'comentario': comentario,
      if (fechaDecision != null) 'fecha_decision': fechaDecision,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AprobacionCompanion copyWith({
    Value<String>? id,
    Value<String>? solicitudId,
    Value<String>? coordinadorId,
    Value<String>? usuarioId,
    Value<String>? decision,
    Value<String>? comentario,
    Value<DateTime>? fechaDecision,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return AprobacionCompanion(
      id: id ?? this.id,
      solicitudId: solicitudId ?? this.solicitudId,
      coordinadorId: coordinadorId ?? this.coordinadorId,
      usuarioId: usuarioId ?? this.usuarioId,
      decision: decision ?? this.decision,
      comentario: comentario ?? this.comentario,
      fechaDecision: fechaDecision ?? this.fechaDecision,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (solicitudId.present) {
      map['solicitud_id'] = Variable<String>(solicitudId.value);
    }
    if (coordinadorId.present) {
      map['coordinador_id'] = Variable<String>(coordinadorId.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(decision.value);
    }
    if (comentario.present) {
      map['comentario'] = Variable<String>(comentario.value);
    }
    if (fechaDecision.present) {
      map['fecha_decision'] = Variable<DateTime>(fechaDecision.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AprobacionCompanion(')
          ..write('id: $id, ')
          ..write('solicitudId: $solicitudId, ')
          ..write('coordinadorId: $coordinadorId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('decision: $decision, ')
          ..write('comentario: $comentario, ')
          ..write('fechaDecision: $fechaDecision, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HistorialEstadoTable extends HistorialEstado
    with TableInfo<$HistorialEstadoTable, HistorialEstadoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorialEstadoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _solicitudIdMeta = const VerificationMeta(
    'solicitudId',
  );
  @override
  late final GeneratedColumn<String> solicitudId = GeneratedColumn<String>(
    'solicitud_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoAnteriorMeta = const VerificationMeta(
    'estadoAnterior',
  );
  @override
  late final GeneratedColumn<String> estadoAnterior = GeneratedColumn<String>(
    'estado_anterior',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoNuevoMeta = const VerificationMeta(
    'estadoNuevo',
  );
  @override
  late final GeneratedColumn<String> estadoNuevo = GeneratedColumn<String>(
    'estado_nuevo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _comentarioMeta = const VerificationMeta(
    'comentario',
  );
  @override
  late final GeneratedColumn<String> comentario = GeneratedColumn<String>(
    'comentario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaCambioMeta = const VerificationMeta(
    'fechaCambio',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCambio = GeneratedColumn<DateTime>(
    'fecha_cambio',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    solicitudId,
    usuarioId,
    estadoAnterior,
    estadoNuevo,
    comentario,
    fechaCambio,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial_estado';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistorialEstadoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('solicitud_id')) {
      context.handle(
        _solicitudIdMeta,
        solicitudId.isAcceptableOrUnknown(
          data['solicitud_id']!,
          _solicitudIdMeta,
        ),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('estado_anterior')) {
      context.handle(
        _estadoAnteriorMeta,
        estadoAnterior.isAcceptableOrUnknown(
          data['estado_anterior']!,
          _estadoAnteriorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estadoAnteriorMeta);
    }
    if (data.containsKey('estado_nuevo')) {
      context.handle(
        _estadoNuevoMeta,
        estadoNuevo.isAcceptableOrUnknown(
          data['estado_nuevo']!,
          _estadoNuevoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estadoNuevoMeta);
    }
    if (data.containsKey('comentario')) {
      context.handle(
        _comentarioMeta,
        comentario.isAcceptableOrUnknown(data['comentario']!, _comentarioMeta),
      );
    }
    if (data.containsKey('fecha_cambio')) {
      context.handle(
        _fechaCambioMeta,
        fechaCambio.isAcceptableOrUnknown(
          data['fecha_cambio']!,
          _fechaCambioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCambioMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistorialEstadoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorialEstadoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      solicitudId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solicitud_id'],
      ),
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      estadoAnterior: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado_anterior'],
      )!,
      estadoNuevo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado_nuevo'],
      )!,
      comentario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comentario'],
      ),
      fechaCambio: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_cambio'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $HistorialEstadoTable createAlias(String alias) {
    return $HistorialEstadoTable(attachedDatabase, alias);
  }
}

class HistorialEstadoData extends DataClass
    implements Insertable<HistorialEstadoData> {
  final String id;
  final String? solicitudId;
  final String usuarioId;
  final String estadoAnterior;
  final String estadoNuevo;
  final String? comentario;
  final DateTime fechaCambio;
  final bool pendingSync;
  const HistorialEstadoData({
    required this.id,
    this.solicitudId,
    required this.usuarioId,
    required this.estadoAnterior,
    required this.estadoNuevo,
    this.comentario,
    required this.fechaCambio,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || solicitudId != null) {
      map['solicitud_id'] = Variable<String>(solicitudId);
    }
    map['usuario_id'] = Variable<String>(usuarioId);
    map['estado_anterior'] = Variable<String>(estadoAnterior);
    map['estado_nuevo'] = Variable<String>(estadoNuevo);
    if (!nullToAbsent || comentario != null) {
      map['comentario'] = Variable<String>(comentario);
    }
    map['fecha_cambio'] = Variable<DateTime>(fechaCambio);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  HistorialEstadoCompanion toCompanion(bool nullToAbsent) {
    return HistorialEstadoCompanion(
      id: Value(id),
      solicitudId: solicitudId == null && nullToAbsent
          ? const Value.absent()
          : Value(solicitudId),
      usuarioId: Value(usuarioId),
      estadoAnterior: Value(estadoAnterior),
      estadoNuevo: Value(estadoNuevo),
      comentario: comentario == null && nullToAbsent
          ? const Value.absent()
          : Value(comentario),
      fechaCambio: Value(fechaCambio),
      pendingSync: Value(pendingSync),
    );
  }

  factory HistorialEstadoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorialEstadoData(
      id: serializer.fromJson<String>(json['id']),
      solicitudId: serializer.fromJson<String?>(json['solicitudId']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      estadoAnterior: serializer.fromJson<String>(json['estadoAnterior']),
      estadoNuevo: serializer.fromJson<String>(json['estadoNuevo']),
      comentario: serializer.fromJson<String?>(json['comentario']),
      fechaCambio: serializer.fromJson<DateTime>(json['fechaCambio']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'solicitudId': serializer.toJson<String?>(solicitudId),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'estadoAnterior': serializer.toJson<String>(estadoAnterior),
      'estadoNuevo': serializer.toJson<String>(estadoNuevo),
      'comentario': serializer.toJson<String?>(comentario),
      'fechaCambio': serializer.toJson<DateTime>(fechaCambio),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  HistorialEstadoData copyWith({
    String? id,
    Value<String?> solicitudId = const Value.absent(),
    String? usuarioId,
    String? estadoAnterior,
    String? estadoNuevo,
    Value<String?> comentario = const Value.absent(),
    DateTime? fechaCambio,
    bool? pendingSync,
  }) => HistorialEstadoData(
    id: id ?? this.id,
    solicitudId: solicitudId.present ? solicitudId.value : this.solicitudId,
    usuarioId: usuarioId ?? this.usuarioId,
    estadoAnterior: estadoAnterior ?? this.estadoAnterior,
    estadoNuevo: estadoNuevo ?? this.estadoNuevo,
    comentario: comentario.present ? comentario.value : this.comentario,
    fechaCambio: fechaCambio ?? this.fechaCambio,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  HistorialEstadoData copyWithCompanion(HistorialEstadoCompanion data) {
    return HistorialEstadoData(
      id: data.id.present ? data.id.value : this.id,
      solicitudId: data.solicitudId.present
          ? data.solicitudId.value
          : this.solicitudId,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      estadoAnterior: data.estadoAnterior.present
          ? data.estadoAnterior.value
          : this.estadoAnterior,
      estadoNuevo: data.estadoNuevo.present
          ? data.estadoNuevo.value
          : this.estadoNuevo,
      comentario: data.comentario.present
          ? data.comentario.value
          : this.comentario,
      fechaCambio: data.fechaCambio.present
          ? data.fechaCambio.value
          : this.fechaCambio,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistorialEstadoData(')
          ..write('id: $id, ')
          ..write('solicitudId: $solicitudId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('estadoAnterior: $estadoAnterior, ')
          ..write('estadoNuevo: $estadoNuevo, ')
          ..write('comentario: $comentario, ')
          ..write('fechaCambio: $fechaCambio, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    solicitudId,
    usuarioId,
    estadoAnterior,
    estadoNuevo,
    comentario,
    fechaCambio,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialEstadoData &&
          other.id == this.id &&
          other.solicitudId == this.solicitudId &&
          other.usuarioId == this.usuarioId &&
          other.estadoAnterior == this.estadoAnterior &&
          other.estadoNuevo == this.estadoNuevo &&
          other.comentario == this.comentario &&
          other.fechaCambio == this.fechaCambio &&
          other.pendingSync == this.pendingSync);
}

class HistorialEstadoCompanion extends UpdateCompanion<HistorialEstadoData> {
  final Value<String> id;
  final Value<String?> solicitudId;
  final Value<String> usuarioId;
  final Value<String> estadoAnterior;
  final Value<String> estadoNuevo;
  final Value<String?> comentario;
  final Value<DateTime> fechaCambio;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const HistorialEstadoCompanion({
    this.id = const Value.absent(),
    this.solicitudId = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.estadoAnterior = const Value.absent(),
    this.estadoNuevo = const Value.absent(),
    this.comentario = const Value.absent(),
    this.fechaCambio = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistorialEstadoCompanion.insert({
    required String id,
    this.solicitudId = const Value.absent(),
    required String usuarioId,
    required String estadoAnterior,
    required String estadoNuevo,
    this.comentario = const Value.absent(),
    required DateTime fechaCambio,
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       usuarioId = Value(usuarioId),
       estadoAnterior = Value(estadoAnterior),
       estadoNuevo = Value(estadoNuevo),
       fechaCambio = Value(fechaCambio);
  static Insertable<HistorialEstadoData> custom({
    Expression<String>? id,
    Expression<String>? solicitudId,
    Expression<String>? usuarioId,
    Expression<String>? estadoAnterior,
    Expression<String>? estadoNuevo,
    Expression<String>? comentario,
    Expression<DateTime>? fechaCambio,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (solicitudId != null) 'solicitud_id': solicitudId,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (estadoAnterior != null) 'estado_anterior': estadoAnterior,
      if (estadoNuevo != null) 'estado_nuevo': estadoNuevo,
      if (comentario != null) 'comentario': comentario,
      if (fechaCambio != null) 'fecha_cambio': fechaCambio,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistorialEstadoCompanion copyWith({
    Value<String>? id,
    Value<String?>? solicitudId,
    Value<String>? usuarioId,
    Value<String>? estadoAnterior,
    Value<String>? estadoNuevo,
    Value<String?>? comentario,
    Value<DateTime>? fechaCambio,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return HistorialEstadoCompanion(
      id: id ?? this.id,
      solicitudId: solicitudId ?? this.solicitudId,
      usuarioId: usuarioId ?? this.usuarioId,
      estadoAnterior: estadoAnterior ?? this.estadoAnterior,
      estadoNuevo: estadoNuevo ?? this.estadoNuevo,
      comentario: comentario ?? this.comentario,
      fechaCambio: fechaCambio ?? this.fechaCambio,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (solicitudId.present) {
      map['solicitud_id'] = Variable<String>(solicitudId.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (estadoAnterior.present) {
      map['estado_anterior'] = Variable<String>(estadoAnterior.value);
    }
    if (estadoNuevo.present) {
      map['estado_nuevo'] = Variable<String>(estadoNuevo.value);
    }
    if (comentario.present) {
      map['comentario'] = Variable<String>(comentario.value);
    }
    if (fechaCambio.present) {
      map['fecha_cambio'] = Variable<DateTime>(fechaCambio.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialEstadoCompanion(')
          ..write('id: $id, ')
          ..write('solicitudId: $solicitudId, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('estadoAnterior: $estadoAnterior, ')
          ..write('estadoNuevo: $estadoNuevo, ')
          ..write('comentario: $comentario, ')
          ..write('fechaCambio: $fechaCambio, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $SolicitudMovilidadTable solicitudMovilidad =
      $SolicitudMovilidadTable(this);
  late final $UniversidadDestinoTable universidadDestino =
      $UniversidadDestinoTable(this);
  late final $DocumentoTable documento = $DocumentoTable(this);
  late final $AprobacionTable aprobacion = $AprobacionTable(this);
  late final $HistorialEstadoTable historialEstado = $HistorialEstadoTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarios,
    solicitudMovilidad,
    universidadDestino,
    documento,
    aprobacion,
    historialEstado,
  ];
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      required String id,
      required String nombre,
      required String apellido,
      required String email,
      required String rol,
      Value<String> estado,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<String> id,
      Value<String> nombre,
      Value<String> apellido,
      Value<String> email,
      Value<String> rol,
      Value<String> estado,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
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

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellido => $composableBuilder(
    column: $table.apellido,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
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

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellido => $composableBuilder(
    column: $table.apellido,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get apellido =>
      $composableBuilder(column: $table.apellido, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          UsuarioData,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (
            UsuarioData,
            BaseReferences<_$AppDatabase, $UsuariosTable, UsuarioData>,
          ),
          UsuarioData,
          PrefetchHooks Function()
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> apellido = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> rol = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nombre: nombre,
                apellido: apellido,
                email: email,
                rol: rol,
                estado: estado,
                createdAt: createdAt,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                required String apellido,
                required String email,
                required String rol,
                Value<String> estado = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion.insert(
                id: id,
                nombre: nombre,
                apellido: apellido,
                email: email,
                rol: rol,
                estado: estado,
                createdAt: createdAt,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      UsuarioData,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (UsuarioData, BaseReferences<_$AppDatabase, $UsuariosTable, UsuarioData>),
      UsuarioData,
      PrefetchHooks Function()
    >;
typedef $$SolicitudMovilidadTableCreateCompanionBuilder =
    SolicitudMovilidadCompanion Function({
      required String id,
      required String estudianteId,
      required String tipoMovilidad,
      Value<String> nombres,
      Value<String> apellidos,
      Value<String> tipoDocumento,
      Value<String> numeroDocumento,
      required DateTime fechaNacimiento,
      required String emailInstitucional,
      required String emailPersonal,
      required String telefono,
      required String contactoEmergencia,
      required String relacionContacto,
      Value<String> universidadActual,
      Value<String> facultad,
      required String universidadDestinoId,
      Value<String> universidadDestinoNombre,
      Value<String> paisDestino,
      Value<String> ciudadDestino,
      Value<String> facultadDestino,
      Value<String> areaEstudio,
      required String programaAcademico,
      required int semestre,
      Value<double> promedioAcumulado,
      Value<String> nivelIdioma,
      Value<String> puntajeIdioma,
      Value<String> semestreIntercambio,
      Value<DateTime?> fechaViaje,
      Value<DateTime?> fechaRegreso,
      Value<String> estado,
      Value<bool> bloqueada,
      required DateTime fechaCreacion,
      required DateTime fechaActualizacion,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$SolicitudMovilidadTableUpdateCompanionBuilder =
    SolicitudMovilidadCompanion Function({
      Value<String> id,
      Value<String> estudianteId,
      Value<String> tipoMovilidad,
      Value<String> nombres,
      Value<String> apellidos,
      Value<String> tipoDocumento,
      Value<String> numeroDocumento,
      Value<DateTime> fechaNacimiento,
      Value<String> emailInstitucional,
      Value<String> emailPersonal,
      Value<String> telefono,
      Value<String> contactoEmergencia,
      Value<String> relacionContacto,
      Value<String> universidadActual,
      Value<String> facultad,
      Value<String> universidadDestinoId,
      Value<String> universidadDestinoNombre,
      Value<String> paisDestino,
      Value<String> ciudadDestino,
      Value<String> facultadDestino,
      Value<String> areaEstudio,
      Value<String> programaAcademico,
      Value<int> semestre,
      Value<double> promedioAcumulado,
      Value<String> nivelIdioma,
      Value<String> puntajeIdioma,
      Value<String> semestreIntercambio,
      Value<DateTime?> fechaViaje,
      Value<DateTime?> fechaRegreso,
      Value<String> estado,
      Value<bool> bloqueada,
      Value<DateTime> fechaCreacion,
      Value<DateTime> fechaActualizacion,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

class $$SolicitudMovilidadTableFilterComposer
    extends Composer<_$AppDatabase, $SolicitudMovilidadTable> {
  $$SolicitudMovilidadTableFilterComposer({
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

  ColumnFilters<String> get estudianteId => $composableBuilder(
    column: $table.estudianteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoMovilidad => $composableBuilder(
    column: $table.tipoMovilidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombres => $composableBuilder(
    column: $table.nombres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidos => $composableBuilder(
    column: $table.apellidos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeroDocumento => $composableBuilder(
    column: $table.numeroDocumento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emailInstitucional => $composableBuilder(
    column: $table.emailInstitucional,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emailPersonal => $composableBuilder(
    column: $table.emailPersonal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactoEmergencia => $composableBuilder(
    column: $table.contactoEmergencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relacionContacto => $composableBuilder(
    column: $table.relacionContacto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universidadActual => $composableBuilder(
    column: $table.universidadActual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get facultad => $composableBuilder(
    column: $table.facultad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universidadDestinoId => $composableBuilder(
    column: $table.universidadDestinoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universidadDestinoNombre => $composableBuilder(
    column: $table.universidadDestinoNombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paisDestino => $composableBuilder(
    column: $table.paisDestino,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciudadDestino => $composableBuilder(
    column: $table.ciudadDestino,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get facultadDestino => $composableBuilder(
    column: $table.facultadDestino,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get areaEstudio => $composableBuilder(
    column: $table.areaEstudio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get programaAcademico => $composableBuilder(
    column: $table.programaAcademico,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semestre => $composableBuilder(
    column: $table.semestre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get promedioAcumulado => $composableBuilder(
    column: $table.promedioAcumulado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nivelIdioma => $composableBuilder(
    column: $table.nivelIdioma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puntajeIdioma => $composableBuilder(
    column: $table.puntajeIdioma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get semestreIntercambio => $composableBuilder(
    column: $table.semestreIntercambio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaViaje => $composableBuilder(
    column: $table.fechaViaje,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaRegreso => $composableBuilder(
    column: $table.fechaRegreso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bloqueada => $composableBuilder(
    column: $table.bloqueada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaActualizacion => $composableBuilder(
    column: $table.fechaActualizacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SolicitudMovilidadTableOrderingComposer
    extends Composer<_$AppDatabase, $SolicitudMovilidadTable> {
  $$SolicitudMovilidadTableOrderingComposer({
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

  ColumnOrderings<String> get estudianteId => $composableBuilder(
    column: $table.estudianteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoMovilidad => $composableBuilder(
    column: $table.tipoMovilidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombres => $composableBuilder(
    column: $table.nombres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidos => $composableBuilder(
    column: $table.apellidos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroDocumento => $composableBuilder(
    column: $table.numeroDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emailInstitucional => $composableBuilder(
    column: $table.emailInstitucional,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emailPersonal => $composableBuilder(
    column: $table.emailPersonal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactoEmergencia => $composableBuilder(
    column: $table.contactoEmergencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relacionContacto => $composableBuilder(
    column: $table.relacionContacto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universidadActual => $composableBuilder(
    column: $table.universidadActual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facultad => $composableBuilder(
    column: $table.facultad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universidadDestinoId => $composableBuilder(
    column: $table.universidadDestinoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universidadDestinoNombre => $composableBuilder(
    column: $table.universidadDestinoNombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paisDestino => $composableBuilder(
    column: $table.paisDestino,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciudadDestino => $composableBuilder(
    column: $table.ciudadDestino,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facultadDestino => $composableBuilder(
    column: $table.facultadDestino,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get areaEstudio => $composableBuilder(
    column: $table.areaEstudio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get programaAcademico => $composableBuilder(
    column: $table.programaAcademico,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semestre => $composableBuilder(
    column: $table.semestre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get promedioAcumulado => $composableBuilder(
    column: $table.promedioAcumulado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nivelIdioma => $composableBuilder(
    column: $table.nivelIdioma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puntajeIdioma => $composableBuilder(
    column: $table.puntajeIdioma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get semestreIntercambio => $composableBuilder(
    column: $table.semestreIntercambio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaViaje => $composableBuilder(
    column: $table.fechaViaje,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaRegreso => $composableBuilder(
    column: $table.fechaRegreso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bloqueada => $composableBuilder(
    column: $table.bloqueada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaActualizacion => $composableBuilder(
    column: $table.fechaActualizacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SolicitudMovilidadTableAnnotationComposer
    extends Composer<_$AppDatabase, $SolicitudMovilidadTable> {
  $$SolicitudMovilidadTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get estudianteId => $composableBuilder(
    column: $table.estudianteId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipoMovilidad => $composableBuilder(
    column: $table.tipoMovilidad,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombres =>
      $composableBuilder(column: $table.nombres, builder: (column) => column);

  GeneratedColumn<String> get apellidos =>
      $composableBuilder(column: $table.apellidos, builder: (column) => column);

  GeneratedColumn<String> get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get numeroDocumento => $composableBuilder(
    column: $table.numeroDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emailInstitucional => $composableBuilder(
    column: $table.emailInstitucional,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emailPersonal => $composableBuilder(
    column: $table.emailPersonal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get contactoEmergencia => $composableBuilder(
    column: $table.contactoEmergencia,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relacionContacto => $composableBuilder(
    column: $table.relacionContacto,
    builder: (column) => column,
  );

  GeneratedColumn<String> get universidadActual => $composableBuilder(
    column: $table.universidadActual,
    builder: (column) => column,
  );

  GeneratedColumn<String> get facultad =>
      $composableBuilder(column: $table.facultad, builder: (column) => column);

  GeneratedColumn<String> get universidadDestinoId => $composableBuilder(
    column: $table.universidadDestinoId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get universidadDestinoNombre => $composableBuilder(
    column: $table.universidadDestinoNombre,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paisDestino => $composableBuilder(
    column: $table.paisDestino,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ciudadDestino => $composableBuilder(
    column: $table.ciudadDestino,
    builder: (column) => column,
  );

  GeneratedColumn<String> get facultadDestino => $composableBuilder(
    column: $table.facultadDestino,
    builder: (column) => column,
  );

  GeneratedColumn<String> get areaEstudio => $composableBuilder(
    column: $table.areaEstudio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get programaAcademico => $composableBuilder(
    column: $table.programaAcademico,
    builder: (column) => column,
  );

  GeneratedColumn<int> get semestre =>
      $composableBuilder(column: $table.semestre, builder: (column) => column);

  GeneratedColumn<double> get promedioAcumulado => $composableBuilder(
    column: $table.promedioAcumulado,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nivelIdioma => $composableBuilder(
    column: $table.nivelIdioma,
    builder: (column) => column,
  );

  GeneratedColumn<String> get puntajeIdioma => $composableBuilder(
    column: $table.puntajeIdioma,
    builder: (column) => column,
  );

  GeneratedColumn<String> get semestreIntercambio => $composableBuilder(
    column: $table.semestreIntercambio,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaViaje => $composableBuilder(
    column: $table.fechaViaje,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaRegreso => $composableBuilder(
    column: $table.fechaRegreso,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<bool> get bloqueada =>
      $composableBuilder(column: $table.bloqueada, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaActualizacion => $composableBuilder(
    column: $table.fechaActualizacion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$SolicitudMovilidadTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SolicitudMovilidadTable,
          SolicitudMobilidadData,
          $$SolicitudMovilidadTableFilterComposer,
          $$SolicitudMovilidadTableOrderingComposer,
          $$SolicitudMovilidadTableAnnotationComposer,
          $$SolicitudMovilidadTableCreateCompanionBuilder,
          $$SolicitudMovilidadTableUpdateCompanionBuilder,
          (
            SolicitudMobilidadData,
            BaseReferences<
              _$AppDatabase,
              $SolicitudMovilidadTable,
              SolicitudMobilidadData
            >,
          ),
          SolicitudMobilidadData,
          PrefetchHooks Function()
        > {
  $$SolicitudMovilidadTableTableManager(
    _$AppDatabase db,
    $SolicitudMovilidadTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SolicitudMovilidadTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SolicitudMovilidadTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SolicitudMovilidadTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> estudianteId = const Value.absent(),
                Value<String> tipoMovilidad = const Value.absent(),
                Value<String> nombres = const Value.absent(),
                Value<String> apellidos = const Value.absent(),
                Value<String> tipoDocumento = const Value.absent(),
                Value<String> numeroDocumento = const Value.absent(),
                Value<DateTime> fechaNacimiento = const Value.absent(),
                Value<String> emailInstitucional = const Value.absent(),
                Value<String> emailPersonal = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> contactoEmergencia = const Value.absent(),
                Value<String> relacionContacto = const Value.absent(),
                Value<String> universidadActual = const Value.absent(),
                Value<String> facultad = const Value.absent(),
                Value<String> universidadDestinoId = const Value.absent(),
                Value<String> universidadDestinoNombre = const Value.absent(),
                Value<String> paisDestino = const Value.absent(),
                Value<String> ciudadDestino = const Value.absent(),
                Value<String> facultadDestino = const Value.absent(),
                Value<String> areaEstudio = const Value.absent(),
                Value<String> programaAcademico = const Value.absent(),
                Value<int> semestre = const Value.absent(),
                Value<double> promedioAcumulado = const Value.absent(),
                Value<String> nivelIdioma = const Value.absent(),
                Value<String> puntajeIdioma = const Value.absent(),
                Value<String> semestreIntercambio = const Value.absent(),
                Value<DateTime?> fechaViaje = const Value.absent(),
                Value<DateTime?> fechaRegreso = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<bool> bloqueada = const Value.absent(),
                Value<DateTime> fechaCreacion = const Value.absent(),
                Value<DateTime> fechaActualizacion = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SolicitudMovilidadCompanion(
                id: id,
                estudianteId: estudianteId,
                tipoMovilidad: tipoMovilidad,
                nombres: nombres,
                apellidos: apellidos,
                tipoDocumento: tipoDocumento,
                numeroDocumento: numeroDocumento,
                fechaNacimiento: fechaNacimiento,
                emailInstitucional: emailInstitucional,
                emailPersonal: emailPersonal,
                telefono: telefono,
                contactoEmergencia: contactoEmergencia,
                relacionContacto: relacionContacto,
                universidadActual: universidadActual,
                facultad: facultad,
                universidadDestinoId: universidadDestinoId,
                universidadDestinoNombre: universidadDestinoNombre,
                paisDestino: paisDestino,
                ciudadDestino: ciudadDestino,
                facultadDestino: facultadDestino,
                areaEstudio: areaEstudio,
                programaAcademico: programaAcademico,
                semestre: semestre,
                promedioAcumulado: promedioAcumulado,
                nivelIdioma: nivelIdioma,
                puntajeIdioma: puntajeIdioma,
                semestreIntercambio: semestreIntercambio,
                fechaViaje: fechaViaje,
                fechaRegreso: fechaRegreso,
                estado: estado,
                bloqueada: bloqueada,
                fechaCreacion: fechaCreacion,
                fechaActualizacion: fechaActualizacion,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String estudianteId,
                required String tipoMovilidad,
                Value<String> nombres = const Value.absent(),
                Value<String> apellidos = const Value.absent(),
                Value<String> tipoDocumento = const Value.absent(),
                Value<String> numeroDocumento = const Value.absent(),
                required DateTime fechaNacimiento,
                required String emailInstitucional,
                required String emailPersonal,
                required String telefono,
                required String contactoEmergencia,
                required String relacionContacto,
                Value<String> universidadActual = const Value.absent(),
                Value<String> facultad = const Value.absent(),
                required String universidadDestinoId,
                Value<String> universidadDestinoNombre = const Value.absent(),
                Value<String> paisDestino = const Value.absent(),
                Value<String> ciudadDestino = const Value.absent(),
                Value<String> facultadDestino = const Value.absent(),
                Value<String> areaEstudio = const Value.absent(),
                required String programaAcademico,
                required int semestre,
                Value<double> promedioAcumulado = const Value.absent(),
                Value<String> nivelIdioma = const Value.absent(),
                Value<String> puntajeIdioma = const Value.absent(),
                Value<String> semestreIntercambio = const Value.absent(),
                Value<DateTime?> fechaViaje = const Value.absent(),
                Value<DateTime?> fechaRegreso = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<bool> bloqueada = const Value.absent(),
                required DateTime fechaCreacion,
                required DateTime fechaActualizacion,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SolicitudMovilidadCompanion.insert(
                id: id,
                estudianteId: estudianteId,
                tipoMovilidad: tipoMovilidad,
                nombres: nombres,
                apellidos: apellidos,
                tipoDocumento: tipoDocumento,
                numeroDocumento: numeroDocumento,
                fechaNacimiento: fechaNacimiento,
                emailInstitucional: emailInstitucional,
                emailPersonal: emailPersonal,
                telefono: telefono,
                contactoEmergencia: contactoEmergencia,
                relacionContacto: relacionContacto,
                universidadActual: universidadActual,
                facultad: facultad,
                universidadDestinoId: universidadDestinoId,
                universidadDestinoNombre: universidadDestinoNombre,
                paisDestino: paisDestino,
                ciudadDestino: ciudadDestino,
                facultadDestino: facultadDestino,
                areaEstudio: areaEstudio,
                programaAcademico: programaAcademico,
                semestre: semestre,
                promedioAcumulado: promedioAcumulado,
                nivelIdioma: nivelIdioma,
                puntajeIdioma: puntajeIdioma,
                semestreIntercambio: semestreIntercambio,
                fechaViaje: fechaViaje,
                fechaRegreso: fechaRegreso,
                estado: estado,
                bloqueada: bloqueada,
                fechaCreacion: fechaCreacion,
                fechaActualizacion: fechaActualizacion,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SolicitudMovilidadTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SolicitudMovilidadTable,
      SolicitudMobilidadData,
      $$SolicitudMovilidadTableFilterComposer,
      $$SolicitudMovilidadTableOrderingComposer,
      $$SolicitudMovilidadTableAnnotationComposer,
      $$SolicitudMovilidadTableCreateCompanionBuilder,
      $$SolicitudMovilidadTableUpdateCompanionBuilder,
      (
        SolicitudMobilidadData,
        BaseReferences<
          _$AppDatabase,
          $SolicitudMovilidadTable,
          SolicitudMobilidadData
        >,
      ),
      SolicitudMobilidadData,
      PrefetchHooks Function()
    >;
typedef $$UniversidadDestinoTableCreateCompanionBuilder =
    UniversidadDestinoCompanion Function({
      required String id,
      required String nombre,
      required String pais,
      required String ciudad,
      required String tipoMovilidad,
      Value<bool> convenioActivo,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$UniversidadDestinoTableUpdateCompanionBuilder =
    UniversidadDestinoCompanion Function({
      Value<String> id,
      Value<String> nombre,
      Value<String> pais,
      Value<String> ciudad,
      Value<String> tipoMovilidad,
      Value<bool> convenioActivo,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

class $$UniversidadDestinoTableFilterComposer
    extends Composer<_$AppDatabase, $UniversidadDestinoTable> {
  $$UniversidadDestinoTableFilterComposer({
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

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pais => $composableBuilder(
    column: $table.pais,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoMovilidad => $composableBuilder(
    column: $table.tipoMovilidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get convenioActivo => $composableBuilder(
    column: $table.convenioActivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UniversidadDestinoTableOrderingComposer
    extends Composer<_$AppDatabase, $UniversidadDestinoTable> {
  $$UniversidadDestinoTableOrderingComposer({
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

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pais => $composableBuilder(
    column: $table.pais,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoMovilidad => $composableBuilder(
    column: $table.tipoMovilidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get convenioActivo => $composableBuilder(
    column: $table.convenioActivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UniversidadDestinoTableAnnotationComposer
    extends Composer<_$AppDatabase, $UniversidadDestinoTable> {
  $$UniversidadDestinoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get pais =>
      $composableBuilder(column: $table.pais, builder: (column) => column);

  GeneratedColumn<String> get ciudad =>
      $composableBuilder(column: $table.ciudad, builder: (column) => column);

  GeneratedColumn<String> get tipoMovilidad => $composableBuilder(
    column: $table.tipoMovilidad,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get convenioActivo => $composableBuilder(
    column: $table.convenioActivo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$UniversidadDestinoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UniversidadDestinoTable,
          UniversidadDestinoData,
          $$UniversidadDestinoTableFilterComposer,
          $$UniversidadDestinoTableOrderingComposer,
          $$UniversidadDestinoTableAnnotationComposer,
          $$UniversidadDestinoTableCreateCompanionBuilder,
          $$UniversidadDestinoTableUpdateCompanionBuilder,
          (
            UniversidadDestinoData,
            BaseReferences<
              _$AppDatabase,
              $UniversidadDestinoTable,
              UniversidadDestinoData
            >,
          ),
          UniversidadDestinoData,
          PrefetchHooks Function()
        > {
  $$UniversidadDestinoTableTableManager(
    _$AppDatabase db,
    $UniversidadDestinoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UniversidadDestinoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UniversidadDestinoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UniversidadDestinoTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> pais = const Value.absent(),
                Value<String> ciudad = const Value.absent(),
                Value<String> tipoMovilidad = const Value.absent(),
                Value<bool> convenioActivo = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UniversidadDestinoCompanion(
                id: id,
                nombre: nombre,
                pais: pais,
                ciudad: ciudad,
                tipoMovilidad: tipoMovilidad,
                convenioActivo: convenioActivo,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                required String pais,
                required String ciudad,
                required String tipoMovilidad,
                Value<bool> convenioActivo = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UniversidadDestinoCompanion.insert(
                id: id,
                nombre: nombre,
                pais: pais,
                ciudad: ciudad,
                tipoMovilidad: tipoMovilidad,
                convenioActivo: convenioActivo,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UniversidadDestinoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UniversidadDestinoTable,
      UniversidadDestinoData,
      $$UniversidadDestinoTableFilterComposer,
      $$UniversidadDestinoTableOrderingComposer,
      $$UniversidadDestinoTableAnnotationComposer,
      $$UniversidadDestinoTableCreateCompanionBuilder,
      $$UniversidadDestinoTableUpdateCompanionBuilder,
      (
        UniversidadDestinoData,
        BaseReferences<
          _$AppDatabase,
          $UniversidadDestinoTable,
          UniversidadDestinoData
        >,
      ),
      UniversidadDestinoData,
      PrefetchHooks Function()
    >;
typedef $$DocumentoTableCreateCompanionBuilder =
    DocumentoCompanion Function({
      required String id,
      required String solicitudId,
      required String tipoDocumento,
      required String nombreArchivo,
      Value<String> estado,
      required DateTime fechaSubida,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$DocumentoTableUpdateCompanionBuilder =
    DocumentoCompanion Function({
      Value<String> id,
      Value<String> solicitudId,
      Value<String> tipoDocumento,
      Value<String> nombreArchivo,
      Value<String> estado,
      Value<DateTime> fechaSubida,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

class $$DocumentoTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentoTable> {
  $$DocumentoTableFilterComposer({
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

  ColumnFilters<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreArchivo => $composableBuilder(
    column: $table.nombreArchivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaSubida => $composableBuilder(
    column: $table.fechaSubida,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentoTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentoTable> {
  $$DocumentoTableOrderingComposer({
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

  ColumnOrderings<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreArchivo => $composableBuilder(
    column: $table.nombreArchivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaSubida => $composableBuilder(
    column: $table.fechaSubida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentoTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentoTable> {
  $$DocumentoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombreArchivo => $composableBuilder(
    column: $table.nombreArchivo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaSubida => $composableBuilder(
    column: $table.fechaSubida,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$DocumentoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentoTable,
          DocumentoData,
          $$DocumentoTableFilterComposer,
          $$DocumentoTableOrderingComposer,
          $$DocumentoTableAnnotationComposer,
          $$DocumentoTableCreateCompanionBuilder,
          $$DocumentoTableUpdateCompanionBuilder,
          (
            DocumentoData,
            BaseReferences<_$AppDatabase, $DocumentoTable, DocumentoData>,
          ),
          DocumentoData,
          PrefetchHooks Function()
        > {
  $$DocumentoTableTableManager(_$AppDatabase db, $DocumentoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> solicitudId = const Value.absent(),
                Value<String> tipoDocumento = const Value.absent(),
                Value<String> nombreArchivo = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<DateTime> fechaSubida = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentoCompanion(
                id: id,
                solicitudId: solicitudId,
                tipoDocumento: tipoDocumento,
                nombreArchivo: nombreArchivo,
                estado: estado,
                fechaSubida: fechaSubida,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String solicitudId,
                required String tipoDocumento,
                required String nombreArchivo,
                Value<String> estado = const Value.absent(),
                required DateTime fechaSubida,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentoCompanion.insert(
                id: id,
                solicitudId: solicitudId,
                tipoDocumento: tipoDocumento,
                nombreArchivo: nombreArchivo,
                estado: estado,
                fechaSubida: fechaSubida,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentoTable,
      DocumentoData,
      $$DocumentoTableFilterComposer,
      $$DocumentoTableOrderingComposer,
      $$DocumentoTableAnnotationComposer,
      $$DocumentoTableCreateCompanionBuilder,
      $$DocumentoTableUpdateCompanionBuilder,
      (
        DocumentoData,
        BaseReferences<_$AppDatabase, $DocumentoTable, DocumentoData>,
      ),
      DocumentoData,
      PrefetchHooks Function()
    >;
typedef $$AprobacionTableCreateCompanionBuilder =
    AprobacionCompanion Function({
      required String id,
      required String solicitudId,
      required String coordinadorId,
      required String usuarioId,
      required String decision,
      required String comentario,
      required DateTime fechaDecision,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$AprobacionTableUpdateCompanionBuilder =
    AprobacionCompanion Function({
      Value<String> id,
      Value<String> solicitudId,
      Value<String> coordinadorId,
      Value<String> usuarioId,
      Value<String> decision,
      Value<String> comentario,
      Value<DateTime> fechaDecision,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

class $$AprobacionTableFilterComposer
    extends Composer<_$AppDatabase, $AprobacionTable> {
  $$AprobacionTableFilterComposer({
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

  ColumnFilters<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coordinadorId => $composableBuilder(
    column: $table.coordinadorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaDecision => $composableBuilder(
    column: $table.fechaDecision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AprobacionTableOrderingComposer
    extends Composer<_$AppDatabase, $AprobacionTable> {
  $$AprobacionTableOrderingComposer({
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

  ColumnOrderings<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coordinadorId => $composableBuilder(
    column: $table.coordinadorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaDecision => $composableBuilder(
    column: $table.fechaDecision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AprobacionTableAnnotationComposer
    extends Composer<_$AppDatabase, $AprobacionTable> {
  $$AprobacionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coordinadorId => $composableBuilder(
    column: $table.coordinadorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<String> get decision =>
      $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaDecision => $composableBuilder(
    column: $table.fechaDecision,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$AprobacionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AprobacionTable,
          AprobacionData,
          $$AprobacionTableFilterComposer,
          $$AprobacionTableOrderingComposer,
          $$AprobacionTableAnnotationComposer,
          $$AprobacionTableCreateCompanionBuilder,
          $$AprobacionTableUpdateCompanionBuilder,
          (
            AprobacionData,
            BaseReferences<_$AppDatabase, $AprobacionTable, AprobacionData>,
          ),
          AprobacionData,
          PrefetchHooks Function()
        > {
  $$AprobacionTableTableManager(_$AppDatabase db, $AprobacionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AprobacionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AprobacionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AprobacionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> solicitudId = const Value.absent(),
                Value<String> coordinadorId = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<String> decision = const Value.absent(),
                Value<String> comentario = const Value.absent(),
                Value<DateTime> fechaDecision = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AprobacionCompanion(
                id: id,
                solicitudId: solicitudId,
                coordinadorId: coordinadorId,
                usuarioId: usuarioId,
                decision: decision,
                comentario: comentario,
                fechaDecision: fechaDecision,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String solicitudId,
                required String coordinadorId,
                required String usuarioId,
                required String decision,
                required String comentario,
                required DateTime fechaDecision,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AprobacionCompanion.insert(
                id: id,
                solicitudId: solicitudId,
                coordinadorId: coordinadorId,
                usuarioId: usuarioId,
                decision: decision,
                comentario: comentario,
                fechaDecision: fechaDecision,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AprobacionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AprobacionTable,
      AprobacionData,
      $$AprobacionTableFilterComposer,
      $$AprobacionTableOrderingComposer,
      $$AprobacionTableAnnotationComposer,
      $$AprobacionTableCreateCompanionBuilder,
      $$AprobacionTableUpdateCompanionBuilder,
      (
        AprobacionData,
        BaseReferences<_$AppDatabase, $AprobacionTable, AprobacionData>,
      ),
      AprobacionData,
      PrefetchHooks Function()
    >;
typedef $$HistorialEstadoTableCreateCompanionBuilder =
    HistorialEstadoCompanion Function({
      required String id,
      Value<String?> solicitudId,
      required String usuarioId,
      required String estadoAnterior,
      required String estadoNuevo,
      Value<String?> comentario,
      required DateTime fechaCambio,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$HistorialEstadoTableUpdateCompanionBuilder =
    HistorialEstadoCompanion Function({
      Value<String> id,
      Value<String?> solicitudId,
      Value<String> usuarioId,
      Value<String> estadoAnterior,
      Value<String> estadoNuevo,
      Value<String?> comentario,
      Value<DateTime> fechaCambio,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

class $$HistorialEstadoTableFilterComposer
    extends Composer<_$AppDatabase, $HistorialEstadoTable> {
  $$HistorialEstadoTableFilterComposer({
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

  ColumnFilters<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estadoAnterior => $composableBuilder(
    column: $table.estadoAnterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estadoNuevo => $composableBuilder(
    column: $table.estadoNuevo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCambio => $composableBuilder(
    column: $table.fechaCambio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistorialEstadoTableOrderingComposer
    extends Composer<_$AppDatabase, $HistorialEstadoTable> {
  $$HistorialEstadoTableOrderingComposer({
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

  ColumnOrderings<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estadoAnterior => $composableBuilder(
    column: $table.estadoAnterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estadoNuevo => $composableBuilder(
    column: $table.estadoNuevo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCambio => $composableBuilder(
    column: $table.fechaCambio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistorialEstadoTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistorialEstadoTable> {
  $$HistorialEstadoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get solicitudId => $composableBuilder(
    column: $table.solicitudId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<String> get estadoAnterior => $composableBuilder(
    column: $table.estadoAnterior,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estadoNuevo => $composableBuilder(
    column: $table.estadoNuevo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comentario => $composableBuilder(
    column: $table.comentario,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCambio => $composableBuilder(
    column: $table.fechaCambio,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$HistorialEstadoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistorialEstadoTable,
          HistorialEstadoData,
          $$HistorialEstadoTableFilterComposer,
          $$HistorialEstadoTableOrderingComposer,
          $$HistorialEstadoTableAnnotationComposer,
          $$HistorialEstadoTableCreateCompanionBuilder,
          $$HistorialEstadoTableUpdateCompanionBuilder,
          (
            HistorialEstadoData,
            BaseReferences<
              _$AppDatabase,
              $HistorialEstadoTable,
              HistorialEstadoData
            >,
          ),
          HistorialEstadoData,
          PrefetchHooks Function()
        > {
  $$HistorialEstadoTableTableManager(
    _$AppDatabase db,
    $HistorialEstadoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistorialEstadoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistorialEstadoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistorialEstadoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> solicitudId = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<String> estadoAnterior = const Value.absent(),
                Value<String> estadoNuevo = const Value.absent(),
                Value<String?> comentario = const Value.absent(),
                Value<DateTime> fechaCambio = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HistorialEstadoCompanion(
                id: id,
                solicitudId: solicitudId,
                usuarioId: usuarioId,
                estadoAnterior: estadoAnterior,
                estadoNuevo: estadoNuevo,
                comentario: comentario,
                fechaCambio: fechaCambio,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> solicitudId = const Value.absent(),
                required String usuarioId,
                required String estadoAnterior,
                required String estadoNuevo,
                Value<String?> comentario = const Value.absent(),
                required DateTime fechaCambio,
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HistorialEstadoCompanion.insert(
                id: id,
                solicitudId: solicitudId,
                usuarioId: usuarioId,
                estadoAnterior: estadoAnterior,
                estadoNuevo: estadoNuevo,
                comentario: comentario,
                fechaCambio: fechaCambio,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistorialEstadoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistorialEstadoTable,
      HistorialEstadoData,
      $$HistorialEstadoTableFilterComposer,
      $$HistorialEstadoTableOrderingComposer,
      $$HistorialEstadoTableAnnotationComposer,
      $$HistorialEstadoTableCreateCompanionBuilder,
      $$HistorialEstadoTableUpdateCompanionBuilder,
      (
        HistorialEstadoData,
        BaseReferences<
          _$AppDatabase,
          $HistorialEstadoTable,
          HistorialEstadoData
        >,
      ),
      HistorialEstadoData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$SolicitudMovilidadTableTableManager get solicitudMovilidad =>
      $$SolicitudMovilidadTableTableManager(_db, _db.solicitudMovilidad);
  $$UniversidadDestinoTableTableManager get universidadDestino =>
      $$UniversidadDestinoTableTableManager(_db, _db.universidadDestino);
  $$DocumentoTableTableManager get documento =>
      $$DocumentoTableTableManager(_db, _db.documento);
  $$AprobacionTableTableManager get aprobacion =>
      $$AprobacionTableTableManager(_db, _db.aprobacion);
  $$HistorialEstadoTableTableManager get historialEstado =>
      $$HistorialEstadoTableTableManager(_db, _db.historialEstado);
}
