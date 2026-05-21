part of '../main.dart';

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
    required this.controller,
    required this.label,
    required this.onSelected,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
  });

  final TextEditingController controller;
  final String label;
  final ValueChanged<DateTime> onSelected;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;

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
          suffixIcon: const Icon(Icons.calendar_today_outlined),
        ),
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: firstDate,
            lastDate: lastDate,
          );
          if (picked != null) {
            controller.text = formatDate(picked);
            onSelected(picked);
          }
        },
      ),
    );
  }
}
