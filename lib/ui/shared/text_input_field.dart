import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String? value;
  final bool isEditingModeDisabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool obscureText;
  final void Function()? onTap;
  final int? maxLines;
  final TextInputType? keyboardType;
  final int? minLines;
  final void Function(String)? onFieldSubmitted;
  final String? counterText;
  final bool? noPadding;

  const TextInputField({
    super.key,
    required this.label,
    this.value,
    this.isEditingModeDisabled = false,
    this.validator,
    this.onChanged,
    this.decoration,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.onTap,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.onFieldSubmitted,
    this.counterText,
    this.noPadding = false,
  });

  bool get isRequired =>
      !isEditingModeDisabled && validator != null && validator!('') != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: noPadding == true ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.titleMedium,
        minLines: minLines,
        maxLines:
            (readOnly || isEditingModeDisabled) && !obscureText ? null : maxLines,
        keyboardType: keyboardType,
        onTap: onTap,
        readOnly: readOnly || isEditingModeDisabled,
        obscureText: obscureText,
        controller: controller,
        enabled: !isEditingModeDisabled,
        initialValue: value,
        decoration: decoration ??
            InputDecoration(
              counterText: counterText,
              border: isEditingModeDisabled
                  ? InputBorder.none
                  : const OutlineInputBorder(),
              label: Text(label + (isRequired ? ' *' : '')),
              hintText: label,
              suffixIcon: suffixIcon == null || isEditingModeDisabled
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: suffixIcon,
                    ),
            ),
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
