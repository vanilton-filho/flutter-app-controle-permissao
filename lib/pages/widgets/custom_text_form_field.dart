import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final Icon? prefixIcon;
  final String? initValue;
  final String? labelText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? messageError;
  final TextInputType? keyboardType;
  final bool? obscureText;

  CustomTextFormField({
    this.prefixIcon,
    this.initValue,
    this.labelText,
    this.messageError,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.validator,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        initialValue: this.widget.initValue,
        decoration: InputDecoration(
          prefixIcon: this.widget.prefixIcon,
          labelText: this.widget.labelText,
          border: OutlineInputBorder(),
        ),
        keyboardType: this.widget.keyboardType,
        obscureText: this.widget.obscureText!,
        // Se não for passado o validator, então usamos o modo default
        validator: (this.widget.validator == null)
            ? (String? val) => (val!.isEmpty) ? this.widget.messageError : null
            : this.widget.validator,
        onChanged: this.widget.onChanged,
      ),
    );
  }
}
