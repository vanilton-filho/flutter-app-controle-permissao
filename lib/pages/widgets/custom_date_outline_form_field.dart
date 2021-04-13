import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateOutlineFormField extends StatefulWidget {
  TextEditingController? controller;
  TextEditingController? output;
  DateTime? initDate;
  String? labelText;
  Icon? prefixIcon;
  String? messageError;

  CustomDateOutlineFormField({
    this.labelText,
    this.prefixIcon,
    this.controller,
    this.initDate,
    this.messageError,
    this.output,
  });

  @override
  _CustomDateOutlineFormFieldState createState() =>
      _CustomDateOutlineFormFieldState();
}

class _CustomDateOutlineFormFieldState
    extends State<CustomDateOutlineFormField> {
  DateTime? _initDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: this.widget.controller,
        readOnly: true,
        style: this.widget.controller!.text == 'dd/mm/aaaa'
            ? TextStyle(color: Colors.grey)
            : TextStyle(color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: this.widget.prefixIcon,
            labelText: this.widget.labelText,
            border: OutlineInputBorder()),
        onTap: () => _selectorDateWidget(),
        validator: (_) {
          return (this.widget.controller!.text == 'dd/mm/aaaa')
              ? this.widget.messageError
              : null;
        },
      ),
    );
  }

  _selectorDateWidget() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: this.widget.initDate!,
      firstDate: DateTime(1900),
      lastDate: _initDate!,
      locale: Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    );

    if (picked != null && picked != _initDate) {
      setState(() {
        this.widget.controller!.text = DateFormat("dd/MM/yyyy").format(picked);
        this.widget.output!.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
