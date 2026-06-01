String? validateRequired(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Este campo es obligatorio.';
  }
  return null;
}

String? validateEmail(String? value) {
  final requiredError = validateRequired(value);
  if (requiredError != null) return requiredError;

  final email = value!.trim();
  final expression = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!expression.hasMatch(email)) {
    return 'Ingresa un correo valido.';
  }
  return null;
}

String? validatePhone(String? value) {
  final requiredError = validateRequired(value);
  if (requiredError != null) return requiredError;

  final phone = value!.replaceAll(RegExp(r'\s+'), '');
  if (phone.length < 7 || phone.length > 15) {
    return 'Ingresa un telefono valido.';
  }
  return null;
}

String? validatePositiveNumber(String? value) {
  final requiredError = validateRequired(value);
  if (requiredError != null) return requiredError;

  final number = int.tryParse(value!.trim());
  if (number == null || number <= 0) {
    return 'Ingresa un numero mayor a cero.';
  }
  return null;
}

String? validateAverage(String? value) {
  final requiredError = validateRequired(value);
  if (requiredError != null) return requiredError;

  final number = double.tryParse(value!.trim().replaceAll(',', '.'));
  if (number == null || number < 0 || number > 5) {
    return 'Ingresa un promedio entre 0 y 5.';
  }
  return null;
}
