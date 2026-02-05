import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/form_and_validation/complete/registration_data.dart';

import 'custom_textfield.dart';

class PasswordSetupScreen extends StatefulWidget {
  final RegistrationData data;

  const PasswordSetupScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<PasswordSetupScreen> createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _isObscured = true; // State for show/hide password

  // Logic: Complex Password Validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';

    // Regex breakdown:
    // (?=.*?[A-Z])       : At least one upper case
    // (?=.*?[a-z])       : At least one lower case
    // (?=.*?[0-9])       : At least one digit
    // (?=.*?[!@#\$&*~])  : At least one special char
    // .{8,}              : At least 8 characters long
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Must be 8+ chars, 1 Uppercase, 1 Number, 1 Special';
    }
    return null;
  }

  // Logic: Final Submission
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      // Here you would send widget.data and _passController.text to your API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Password"),
        // Back button is automatic in AppBar, but if you needed a manual one:
        // leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Set up Password",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    label: "Password",
                    controller: _passController,
                    obscureText: _isObscured,
                    validator: _validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _isObscured = !_isObscured),
                    ),
                    focusIcon: Icons.lock,
                    unFocusIcon: Icons.lock_outline,
                  ),

                  CustomTextField(
                    label: "Confirm Password",
                    controller: _confirmPassController,
                    obscureText: true,
                    validator: (val) {
                      if (val != _passController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    focusIcon: Icons.lock,
                    unFocusIcon: Icons.lock_outline,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context), // Go Back
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Back"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _onSubmit,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text("Create Account"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
