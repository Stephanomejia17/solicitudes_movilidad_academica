part of '../main.dart';

class ApplicationFormPage extends StatefulWidget {
  const ApplicationFormPage({
    super.key,
    required this.currentUser,
    this.existing,
  });

  final AppUser currentUser;
  final MobilityApplication? existing;

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

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
  late final TextEditingController _currentSemesterController;
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

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _birthDate = existing?.birthDate;
    _travelDate = existing?.travelDate;
    _returnDate = existing?.returnDate;
    _firstNameController = TextEditingController(
      text: existing?.firstName ?? widget.currentUser.firstName,
    );
    _lastNameController = TextEditingController(
      text: existing?.lastName ?? widget.currentUser.lastName,
    );
    _documentTypeController = TextEditingController(
      text: existing?.documentType ?? 'CC',
    );
    _documentNumberController = TextEditingController(
      text: existing?.documentNumber ?? '',
    );
    _birthDateController = TextEditingController(
      text: existing != null ? formatDate(existing.birthDate) : '',
    );
    _institutionalEmailController = TextEditingController(
      text: existing?.institutionalEmail ?? widget.currentUser.email,
    );
    _personalEmailController = TextEditingController(
      text: existing?.personalEmail ?? '',
    );
    _phoneController = TextEditingController(text: existing?.phone ?? '');
    _emergencyContactController = TextEditingController(
      text: existing?.emergencyContact ?? '',
    );
    _relationshipController = TextEditingController(
      text: existing?.relationship ?? '',
    );
    _currentUniversityController = TextEditingController(
      text: existing?.currentUniversity ?? 'Universidad de Medellin',
    );
    _facultyController = TextEditingController(text: existing?.faculty ?? '');
    _programController = TextEditingController(text: existing?.program ?? '');
    _currentSemesterController = TextEditingController(
      text: existing?.currentSemester.toString() ?? '',
    );
    _averageController = TextEditingController(
      text: existing?.average.toString() ?? '',
    );
    _languageLevelController = TextEditingController(
      text: existing?.languageLevel ?? '',
    );
    _languageScoreController = TextEditingController(
      text: existing?.languageScore ?? '',
    );
    _destinationUniversityController = TextEditingController(
      text: existing?.destinationUniversity ?? '',
    );
    _countryController = TextEditingController(text: existing?.country ?? '');
    _cityController = TextEditingController(text: existing?.city ?? '');
    _destinationFacultyController = TextEditingController(
      text: existing?.destinationFaculty ?? '',
    );
    _studyAreaController = TextEditingController(
      text: existing?.studyArea ?? '',
    );
    _exchangeSemesterController = TextEditingController(
      text: existing?.exchangeSemester ?? '',
    );
    _travelDateController = TextEditingController(
      text: existing != null ? formatDate(existing.travelDate) : '',
    );
    _returnDateController = TextEditingController(
      text: existing != null ? formatDate(existing.returnDate) : '',
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
      _currentSemesterController,
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
    final state = AppStateScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar solicitud' : 'Nueva solicitud'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepTapped: (step) => setState(() => _currentStep = step),
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep += 1);
            } else {
              _save();
            }
          },
          onStepCancel: () {
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
                runSpacing: 12,
                children: [
                  FilledButton(
                    onPressed: state.isBusy ? null : details.onStepContinue,
                    child: Text(
                      _currentStep == 2
                          ? (state.isBusy
                                ? 'Guardando...'
                                : 'Guardar solicitud')
                          : 'Continuar',
                    ),
                  ),
                  OutlinedButton(
                    onPressed: state.isBusy ? null : details.onStepCancel,
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
                  _buildTextField(_firstNameController, 'Nombres'),
                  _buildTextField(_lastNameController, 'Apellidos'),
                  _buildTextField(_documentTypeController, 'Tipo de documento'),
                  _buildTextField(
                    _documentNumberController,
                    'Numero de documento',
                    keyboardType: TextInputType.number,
                  ),
                  _DatePickerField(
                    controller: _birthDateController,
                    label: 'Fecha de nacimiento',
                    onSelected: (value) {
                      _birthDate = value;
                    },
                    initialDate: _birthDate,
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now().subtract(
                      const Duration(days: 365 * 16),
                    ),
                  ),
                  _buildTextField(
                    _institutionalEmailController,
                    'Correo institucional',
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  _buildTextField(
                    _personalEmailController,
                    'Correo personal',
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  _buildTextField(
                    _phoneController,
                    'Numero celular',
                    keyboardType: TextInputType.phone,
                    validator: validatePhone,
                  ),
                  _buildTextField(
                    _emergencyContactController,
                    'Contacto de emergencia',
                  ),
                  _buildTextField(_relationshipController, 'Parentesco'),
                ],
              ),
            ),
            Step(
              isActive: _currentStep >= 1,
              title: const Text('Academica'),
              content: Column(
                children: [
                  _buildTextField(
                    _currentUniversityController,
                    'Universidad actual',
                  ),
                  _buildTextField(_facultyController, 'Facultad'),
                  _buildTextField(_programController, 'Programa academico'),
                  _buildTextField(
                    _currentSemesterController,
                    'Semestre actual',
                    keyboardType: TextInputType.number,
                    validator: validatePositiveNumber,
                  ),
                  _buildTextField(
                    _averageController,
                    'Promedio acumulado',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: validateAverage,
                  ),
                  _buildTextField(_languageLevelController, 'Nivel de idioma'),
                  _buildTextField(
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
                  _buildTextField(
                    _destinationUniversityController,
                    'Universidad destino',
                  ),
                  _buildTextField(_countryController, 'Pais'),
                  _buildTextField(_cityController, 'Ciudad'),
                  _buildTextField(
                    _destinationFacultyController,
                    'Facultad destino',
                  ),
                  _buildTextField(_studyAreaController, 'Area de estudio'),
                  _buildTextField(
                    _exchangeSemesterController,
                    'Semestre de intercambio',
                  ),
                  _DatePickerField(
                    controller: _travelDateController,
                    label: 'Fecha estimada de viaje',
                    onSelected: (value) {
                      _travelDate = value;
                    },
                    initialDate: _travelDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                  ),
                  _DatePickerField(
                    controller: _returnDateController,
                    label: 'Fecha estimada de regreso',
                    onSelected: (value) {
                      _returnDate = value;
                    },
                    initialDate: _returnDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
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
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_birthDate == null || _travelDate == null || _returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todas las fechas requeridas.')),
      );
      return;
    }
    if (_returnDate!.isBefore(_travelDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La fecha de regreso debe ser posterior al viaje.'),
        ),
      );
      return;
    }

    final state = AppStateScope.of(context);
    final application = MobilityApplication(
      id: widget.existing?.id ?? '',
      userEmail: widget.currentUser.email,
      createdAt: widget.existing?.createdAt ?? DateTime.now(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      documentType: _documentTypeController.text.trim(),
      documentNumber: _documentNumberController.text.trim(),
      birthDate: _birthDate!,
      institutionalEmail: _institutionalEmailController.text.trim(),
      personalEmail: _personalEmailController.text.trim(),
      phone: _phoneController.text.trim(),
      emergencyContact: _emergencyContactController.text.trim(),
      relationship: _relationshipController.text.trim(),
      currentUniversity: _currentUniversityController.text.trim(),
      faculty: _facultyController.text.trim(),
      program: _programController.text.trim(),
      currentSemester: int.parse(_currentSemesterController.text.trim()),
      average: double.parse(
        _averageController.text.trim().replaceAll(',', '.'),
      ),
      languageLevel: _languageLevelController.text.trim(),
      languageScore: _languageScoreController.text.trim(),
      destinationUniversity: _destinationUniversityController.text.trim(),
      country: _countryController.text.trim(),
      city: _cityController.text.trim(),
      destinationFaculty: _destinationFacultyController.text.trim(),
      studyArea: _studyAreaController.text.trim(),
      exchangeSemester: _exchangeSemesterController.text.trim(),
      travelDate: _travelDate!,
      returnDate: _returnDate!,
      status: widget.existing?.status ?? ApplicationStatus.pending,
      adminComment: widget.existing?.adminComment ?? '',
      rejectionReason: widget.existing?.rejectionReason ?? '',
    );

    if (widget.existing == null) {
      await state.createApplication(application);
    } else {
      await state.updateApplication(application);
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.existing == null
              ? 'Solicitud creada exitosamente.'
              : 'Solicitud actualizada exitosamente.',
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}
