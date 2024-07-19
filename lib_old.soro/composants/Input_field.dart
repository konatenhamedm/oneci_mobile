import 'package:flutter/material.dart';
import 'package:oneci/widgets/form-helper.dart';

class CustomInputField extends StatelessWidget {
  final Icon icon;
  final String label;
  final String hint;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final int maxLength;
  final int minLines;
  final int maxLines;

  const CustomInputField({
    Key? key,
    required this.icon,
    required this.label,
    required this.hint,
    required this.validator,
    required this.onSaved,
    required this.keyboardType,
    this.maxLength = 11,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: FormHelper.inputFieldWidget(
        context,
        icon,
        label,
        hint,
        validator,
        onSaved,
        maxLength,
        keyboardType,
        minLines,
        maxLines,
      ),
    );
  }
}
