import 'package:flutter/material.dart';
import 'package:flutter_basics_1/pages/form_and_validation/complete/password_setup_screen.dart';
import 'package:flutter_basics_1/pages/form_and_validation/complete/registration_data.dart';
import 'package:flutter_basics_1/widgets/reusable_widgets.dart';

import 'custom_textfield.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final data = RegistrationData(
        firstName: _firstNameController.text,
        username: _usernameController.text,
        mobile: _mobileController.text,
        email: _emailController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordSetupScreen(data: data),
        ),
      );
    }
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Create Account'),
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
                    "Personal Information",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "First Name",
                    controller: _firstNameController,
                    validator: _requiredValidator,
                    focusIcon: Icons.person,
                    unFocusIcon: Icons.person_outline,
                  ),
                  CustomTextField(
                    label: "Username",
                    controller: _usernameController,
                    validator: _requiredValidator,
                    focusIcon: Icons.person,
                    unFocusIcon: Icons.person_outline,
                  ),
                  CustomTextField(
                    label: "Mobile Number",
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.length < 10) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                    focusIcon: Icons.phone,
                    unFocusIcon: Icons.phone_outlined,
                  ),
                  CustomTextField(
                    label: "Email Address",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || !val.contains('@')) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    focusIcon: Icons.email,
                    unFocusIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: _onNextPressed,
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(vertical: 16),
                  //   ),
                  //   child: const Text("Next"),
                  // ),
                  GestureDetector(
                    onTap: _onNextPressed,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightBlueAccent, Colors.blue],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
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
