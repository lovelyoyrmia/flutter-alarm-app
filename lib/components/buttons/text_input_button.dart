import 'package:flutter/material.dart';

class TextInputButton extends StatelessWidget {
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onPressed;
  final String? initialValue;
  final IconData? icon;
  final String title;
  final bool readOnly;

  const TextInputButton({
    Key? key,
    required this.readOnly,
    required this.title,
    this.icon,
    this.onPressed,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onPressed,
        onChanged: onChanged,
        initialValue: initialValue,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: title,
          suffixIcon: Icon(icon),
        ),
      ),
    );
  }
}
