import 'package:flutter/material.dart';

class ProfileField extends StatefulWidget {
  final String label;
  final String initialData;
  final Function validator;
  final Function onSaved;
  final bool enabled;

  ProfileField({
    @required this.label,
    @required this.initialData,
    this.validator,
    this.onSaved,
    this.enabled,
  });

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initialData;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(fontSize: 14),
      ),
      style: TextStyle(fontSize: 16),
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
