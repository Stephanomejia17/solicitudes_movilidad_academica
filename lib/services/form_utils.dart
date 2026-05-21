part of '../main.dart';

MapEntry<String, String> _detailRow(String label, String value) =>
    MapEntry<String, String>(label, value);

String? validateRequired(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Este campo es obligatorio.';
  }
  return null;
}

String? validateEmail(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!regex.hasMatch(value!.trim())) {
    return 'Ingresa un correo valido.';
  }
  return null;
}

String? validatePassword(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  if (value!.trim().length < 8) {
    return 'La contrasena debe tener minimo 8 caracteres.';
  }
  return null;
}

String? validatePhone(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final regex = RegExp(r'^\d{7,15}$');
  if (!regex.hasMatch(value!.trim())) {
    return 'Ingresa un numero valido.';
  }
  return null;
}

String? validatePositiveNumber(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final parsed = int.tryParse(value!.trim());
  if (parsed == null || parsed <= 0) {
    return 'Ingresa un numero valido.';
  }
  return null;
}

String? validateAverage(String? value) {
  final required = validateRequired(value);
  if (required != null) {
    return required;
  }
  final parsed = double.tryParse(value!.trim().replaceAll(',', '.'));
  if (parsed == null) {
    return 'Ingresa un promedio valido.';
  }
  if (parsed < 3.5) {
    return 'El promedio minimo es 3.5.';
  }
  return null;
}

String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}
