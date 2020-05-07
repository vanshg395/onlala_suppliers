import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function validator;
  final Function onSaved;

  ProfileField(
      {@required this.label, this.controller, this.validator, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 20),
      ),
      style: TextStyle(fontSize: 20),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
