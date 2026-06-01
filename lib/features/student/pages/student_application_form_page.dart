import 'package:flutter/material.dart';

import '../../../data/app_database.dart';
import '../services/student_application_repository.dart';
import '../validators/student_application_validators.dart';
import '../widgets/student_dashboard_widgets.dart';

class StudentApplicationFormPage extends StatefulWidget {
  const StudentApplicationFormPage({
    super.key,
    required this.user,
    this.existing,
  });

  final UsuarioData user;
  final SolicitudMobilidadData? existing;

  @override
  State<StudentApplicationFormPage> createState() =>
      _StudentApplicationFormPageState();
}

class _StudentApplicationFormPageState
    extends State<StudentApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _saving = false;

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _documentTypeController;
  late final TextEditingController _documentNumberController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _institutionalEmailController;
  late final TextEditingController _personalEmailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emergencyContactController;
  late final TextEditingController _relationshipController;
  late final TextEditingController _currentUniversityController;
  late final TextEditingController _facultyController;
  late final TextEditingController _programController;
  late final TextEditingController _semesterController;
  late final TextEditingController _averageController;
  late final TextEditingController _languageLevelController;
  late final TextEditingController _languageScoreController;
  late final TextEditingController _destinationUniversityController;
  late final TextEditingController _countryController;
  late final TextEditingController _cityController;
  late final TextEditingController _destinationFacultyController;
  late final TextEditingController _studyAreaController;
  late final TextEditingController _exchangeSemesterController;
  late final TextEditingController _travelDateController;
  late final TextEditingController _returnDateController;

  DateTime? _birthDate;
  DateTime? _travelDate;
  DateTime? _returnDate;
  String _mobilityType = 'internacional';
  String _destinationUniversityId = '';

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _birthDate = existing?.fechaNacimiento;
    _travelDate = existing?.fechaViaje;
    _returnDate = existing?.fechaRegreso;
    _mobilityType = existing?.tipoMovilidad ?? 'internacional';
    _destinationUniversityId = existing?.universidadDestinoId ?? '';
    _firstNameController = TextEditingController(
      text: existing?.nombres.isNotEmpty == true
          ? existing!.nombres
          : widget.user.nombre,
    );
    _lastNameController = TextEditingController(
      text: existing?.apellidos.isNotEmpty == true
          ? existing!.apellidos
          : widget.user.apellido,
    );
    _documentTypeController = TextEditingController(
      text: existing?.tipoDocumento ?? 'CC',
    );
    _documentNumberController = TextEditingController(
      text: existing?.numeroDocumento ?? '',
    );
    _birthDateController = TextEditingController(
      text: existing == null ? '' : formatStudentDate(existing.fechaNacimiento),
    );
    _institutionalEmailController = TextEditingController(
      text: existing?.emailInstitucional ?? widget.user.email,
    );
    _personalEmailController = TextEditingController(
      text: existing?.emailPersonal ?? '',
    );
    _phoneController = TextEditingController(text: existing?.telefono ?? '');
    _emergencyContactController = TextEditingController(
      text: existing?.contactoEmergencia ?? '',
    );
    _relationshipController = TextEditingController(
      text: existing?.relacionContacto ?? '',
    );
    _currentUniversityController = TextEditingController(
      text: existing?.universidadActual ?? 'Universidad de Medellin',
    );
    _facultyController = TextEditingController(text: existing?.facultad ?? '');
    _programController = TextEditingController(
      text: existing?.programaAcademico ?? '',
    );
    _semesterController = TextEditingController(
      text: existing == null ? '' : existing.semestre.toString(),
    );
    _averageController = TextEditingController(
      text: existing == null ? '' : existing.promedioAcumulado.toString(),
    );
    _languageLevelController = TextEditingController(
      text: existing?.nivelIdioma ?? '',
    );
    _languageScoreController = TextEditingController(
      text: existing?.puntajeIdioma ?? '',
    );
    _destinationUniversityController = TextEditingController(
      text: existing?.universidadDestinoNombre ?? '',
    );
    _countryController = TextEditingController(
      text: existing?.paisDestino ?? '',
    );
    _cityController = TextEditingController(
      text: existing?.ciudadDestino ?? '',
    );
    _destinationFacultyController = TextEditingController(
      text: existing?.facultadDestino ?? '',
    );
    _studyAreaController = TextEditingController(
      text: existing?.areaEstudio ?? '',
    );
    _exchangeSemesterController = TextEditingController(
      text: existing?.semestreIntercambio ?? '',
    );
    _travelDateController = TextEditingController(
      text: existing?.fechaViaje == null
          ? ''
          : formatStudentDate(existing?.fechaViaje),
    );
    _returnDateController = TextEditingController(
      text: existing?.fechaRegreso == null
          ? ''
          : formatStudentDate(existing?.fechaRegreso),
    );
  }

  @override
  void dispose() {
    for (final controller in [
      _firstNameController,
      _lastNameController,
      _documentTypeController,
      _documentNumberController,
      _birthDateController,
      _institutionalEmailController,
      _personalEmailController,
      _phoneController,
      _emergencyContactController,
      _relationshipController,
      _currentUniversityController,
      _facultyController,
      _programController,
      _semesterController,
      _averageController,
      _languageLevelController,
      _languageScoreController,
      _destinationUniversityController,
      _countryController,
      _cityController,
      _destinationFacultyController,
      _studyAreaController,
      _exchangeSemesterController,
      _travelDateController,
      _returnDateController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar solicitud' : 'Nueva solicitud'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepTapped: (step) => setState(() => _currentStep = step),
          onStepContinue: _saving
              ? null
              : () {
                  if (_currentStep < 2) {
                    setState(() => _currentStep += 1);
                  } else {
                    _save();
                  }
                },
          onStepCancel: _saving
              ? null
              : () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep -= 1);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Wrap(
                spacing: 12,
                children: [
                  FilledButton(
                    onPressed: details.onStepContinue,
                    child: Text(
                      _currentStep == 2
                          ? (_saving ? 'Guardando...' : 'Guardar solicitud')
                          : 'Continuar',
                    ),
                  ),
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    child: Text(_currentStep == 0 ? 'Cancelar' : 'Atras'),
                  ),
                ],
              ),
            );
          },
          steps: [
            Step(
              isActive: _currentStep >= 0,
              title: const Text('Personal'),
              content: Column(
                children: [
                  _textField(_firstNameController, 'Nombres'),
                  _textField(_lastNameController, 'Apellidos'),
                  _textField(_documentTypeController, 'Tipo de documento'),
                  _textField(
                    _documentNumberController,
                    'Numero de documento',
                    keyboardType: TextInputType.number,
                  ),
                  _DatePickerField(
                    controller: _birthDateController,
                    label: 'Fecha de nacimiento',
                    initialDate: _birthDate,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now().subtract(
                      const Duration(days: 365 * 16),
                    ),
                    onSelected: (value) => _birthDate = value,
                  ),
                  _textField(
                    _institutionalEmailController,
                    'Correo institucional',
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  _textField(
                    _personalEmailController,
                    'Correo personal',
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  _textField(
                    _phoneController,
                    'Numero celular',
                    keyboardType: TextInputType.phone,
                    validator: validatePhone,
                  ),
                  _textField(
                    _emergencyContactController,
                    'Contacto de emergencia',
                  ),
                  _textField(_relationshipController, 'Parentesco'),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 1,
              title: const Text('Academica'),
              content: Column(
                children: [
                  _textField(
                    _currentUniversityController,
                    'Universidad actual',
                  ),
                  _textField(_facultyController, 'Facultad'),
                  _textField(_programController, 'Programa academico'),
                  _textField(
                    _semesterController,
                    'Semestre actual',
                    keyboardType: TextInputType.number,
                    validator: validatePositiveNumber,
                  ),
                  _textField(
                    _averageController,
                    'Promedio acumulado',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: validateAverage,
                  ),
                  _textField(_languageLevelController, 'Nivel de idioma'),
                  _textField(
                    _languageScoreController,
                    'Puntaje TOEFL / IELTS / DELF',
                  ),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 2,
              title: const Text('Movilidad'),
              content: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _mobilityType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de movilidad',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'internacional',
                        child: Text('Internacional'),
                      ),
                      DropdownMenuItem(
                        value: 'nacional',
                        child: Text('Nacional'),
                      ),
                    ],
                    onChanged: (value) =>
                        setState(() => _mobilityType = value!),
                  ),
                  const SizedBox(height: 14),
                  _UniversityField(
                    selectedId: _destinationUniversityId,
                    onChanged: (university) {
                      setState(() {
                        _destinationUniversityId = university.id;
                        _destinationUniversityController.text =
                            university.nombre;
                        _countryController.text = university.pais;
                        _cityController.text = university.ciudad;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  _textField(
                    _destinationUniversityController,
                    'Universidad destino',
                  ),
                  _textField(_countryController, 'Pais'),
                  _textField(_cityController, 'Ciudad'),
                  _textField(_destinationFacultyController, 'Facultad destino'),
                  _textField(_studyAreaController, 'Area de estudio'),
                  _textField(
                    _exchangeSemesterController,
                    'Semestre de intercambio',
                  ),
                  _DatePickerField(
                    controller: _travelDateController,
                    label: 'Fecha estimada de viaje',
                    initialDate: _travelDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                    onSelected: (value) => _travelDate = value,
                  ),
                  _DatePickerField(
                    controller: _returnDateController,
                    label: 'Fecha estimada de regreso',
                    initialDate: _returnDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                    onSelected: (value) => _returnDate = value,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ?? validateRequired,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null || _travelDate == null || _returnDate == null) {
      _showMessage('Completa todas las fechas requeridas.');
      return;
    }
    if (_returnDate!.isBefore(_travelDate!)) {
      _showMessage('La fecha de regreso debe ser posterior al viaje.');
      return;
    }

    setState(() => _saving = true);
    final db = AppStateScope.of(context);
    final repository = StudentApplicationRepository(database: db);
    final draft = StudentApplicationDraft(
      estudiante: widget.user,
      tipoMovilidad: _mobilityType,
      nombres: _firstNameController.text.trim(),
      apellidos: _lastNameController.text.trim(),
      tipoDocumento: _documentTypeController.text.trim(),
      numeroDocumento: _documentNumberController.text.trim(),
      fechaNacimiento: _birthDate!,
      emailInstitucional: _institutionalEmailController.text.trim(),
      emailPersonal: _personalEmailController.text.trim(),
      telefono: _phoneController.text.trim(),
      contactoEmergencia: _emergencyContactController.text.trim(),
      relacionContacto: _relationshipController.text.trim(),
      universidadActual: _currentUniversityController.text.trim(),
      facultad: _facultyController.text.trim(),
      universidadDestinoId: _destinationUniversityId,
      universidadDestinoNombre: _destinationUniversityController.text.trim(),
      paisDestino: _countryController.text.trim(),
      ciudadDestino: _cityController.text.trim(),
      facultadDestino: _destinationFacultyController.text.trim(),
      areaEstudio: _studyAreaController.text.trim(),
      programaAcademico: _programController.text.trim(),
      semestre: int.parse(_semesterController.text.trim()),
      promedioAcumulado: double.parse(
        _averageController.text.trim().replaceAll(',', '.'),
      ),
      nivelIdioma: _languageLevelController.text.trim(),
      puntajeIdioma: _languageScoreController.text.trim(),
      semestreIntercambio: _exchangeSemesterController.text.trim(),
      fechaViaje: _travelDate!,
      fechaRegreso: _returnDate!,
    );

    try {
      if (widget.existing == null) {
        await repository.create(draft);
      } else {
        await repository.update(widget.existing!.id, draft);
      }
      if (!mounted) return;
      _showMessage(
        widget.existing == null
            ? 'Solicitud creada exitosamente.'
            : 'Solicitud actualizada exitosamente.',
      );
      Navigator.of(context).pop();
    } catch (error) {
      if (mounted) _showMessage(error.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
    required this.controller,
    required this.label,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onSelected,
  });

  final TextEditingController controller;
  final String label;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: validateRequired,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_month_outlined),
        ),
        onTap: () async {
          final selected = await showDatePicker(
            context: context,
            initialDate: initialDate ?? firstDate,
            firstDate: firstDate,
            lastDate: lastDate,
          );
          if (selected == null) return;
          controller.text = formatStudentDate(selected);
          onSelected(selected);
        },
      ),
    );
  }
}

class _UniversityField extends StatelessWidget {
  const _UniversityField({required this.selectedId, required this.onChanged});

  final String selectedId;
  final ValueChanged<UniversidadDestinoData> onChanged;

  @override
  Widget build(BuildContext context) {
    final db = AppStateScope.of(context);
    return StreamBuilder<List<UniversidadDestinoData>>(
      stream: db.watchUniversidades(),
      builder: (context, snapshot) {
        final universities = snapshot.data ?? const <UniversidadDestinoData>[];
        return DropdownButtonFormField<String>(
          initialValue: universities.any((item) => item.id == selectedId)
              ? selectedId
              : null,
          decoration: const InputDecoration(labelText: 'Convenio destino'),
          items: universities
              .map(
                (university) => DropdownMenuItem(
                  value: university.id,
                  child: Text('${university.nombre} - ${university.pais}'),
                ),
              )
              .toList(),
          onChanged: (value) {
            final university = universities.firstWhere(
              (item) => item.id == value,
            );
            onChanged(university);
          },
        );
      },
    );
  }
}
