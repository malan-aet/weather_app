import 'package:flutter/material.dart';
import '../utils/app_strings.dart';

class AddCityDialog extends StatefulWidget {
  const AddCityDialog({super.key});

  @override
  State<AddCityDialog> createState() => _AddCityDialogState();
}

class _AddCityDialogState extends State<AddCityDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.addCityDialogTitle),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: AppStrings.enterCityHint,
            prefixIcon: Icon(Icons.location_city),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppStrings.cityNameEmpty;
            }
            return null;
          },
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(AppStrings.add)),
      ],
    );
  }
}
