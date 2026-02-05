import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final String label;
  final IconData unFocusIcon;
  final IconData focusIcon;
  final Function(String?) validator;
  final Function(String? value) onSave;

  const MyTextFormField({
    super.key,
    required this.label,
    required this.unFocusIcon,
    required this.focusIcon,
    required this.validator,
    required this.onSave,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late IconData sIcon;

  @override
  void initState() {
    super.initState();
    sIcon = widget.unFocusIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          sIcon = hasFocus ? widget.focusIcon : widget.unFocusIcon;
        });
      },
      child: TextFormField(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: _inputDecoration(widget.label, widget.unFocusIcon),
        validator: ((value) => widget.validator(value)),
        onSaved: ((value) => widget.onSave(value)),
      ),
    );
  }

  // Helper method to keep code clean and consistent
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return Colors.blueAccent;
        }
        return Colors.grey.shade400;
      }),
      prefixIcon: Icon(sIcon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ), // Lighter border when not focused
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 2,
        ), // Thick blue border when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
