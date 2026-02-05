import 'package:flutter/material.dart';

// REUSABLE WIDGET: Keeps the main code clean and consistent
class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData unFocusIcon;
  final IconData focusIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    required this.unFocusIcon,
    required this.focusIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late IconData sIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sIcon = widget.unFocusIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            sIcon = hasFocus ? widget.focusIcon : widget.unFocusIcon;
          });
        },
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          // The standard UI styling is defined once here
          decoration: _inputDecoration(widget.label, sIcon),
        ),
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
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ), // Lighter border when not focused
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 2,
        ), // Thick blue border when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
