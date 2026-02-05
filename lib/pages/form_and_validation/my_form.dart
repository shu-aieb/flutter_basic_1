import 'package:flutter/material.dart';
import 'package:flutter_basics_1/widgets/my_text_form_field.dart';
import 'package:flutter_basics_1/widgets/reusable_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({super.key});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heading
            Text(
              'Sign Up',
              style: GoogleFonts.happyMonkey(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            //
            SizedBox(height: 5),
            // SubHeading
            Text(
              'Please Create an Account',
              style: GoogleFonts.sansita(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            //
            MyTextFormField(
              label: 'User Name',
              unFocusIcon: Icons.person_outlined,
              focusIcon: Icons.person,
              validator: fullNameValidator,
              onSave: (value) => fullNameOnSave(value),
            ),
            SizedBox(height: 20),
            MyTextFormField(
              label: 'User Name',
              unFocusIcon: Icons.person_outlined,
              focusIcon: Icons.person,
              validator: fullNameValidator,
              onSave: (value) => fullNameOnSave(value),
            ),
          ],
        ),
      ),
    );
  }

  String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  void fullNameOnSave(String? value) {
    print('Name Saved $value');
  }
}
