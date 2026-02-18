import 'package:flutter/material.dart';

class TextFieldUIPage extends StatefulWidget {
  @override
  _TextFieldUIPageState createState() => _TextFieldUIPageState();
}

class _TextFieldUIPageState extends State<TextFieldUIPage> {
  // 1. Form Key for validation
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  // 3. Controllers to retrieve value
  final TextEditingController _nameController = TextEditingController();

  IconData phoneIcon = Icons.phone_android;

  @override
  void dispose() {
    _nameController.dispose(); // Always dispose controllers to free memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Public Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: _nameController,
                    autovalidateMode: AutovalidateMode.always,
                    textCapitalization: TextCapitalization.words,
                    decoration: _inputDecoration(
                      "Full Name",
                      Icons.person_outline,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                    onSaved: ((value) {
                      print('Name Saved $value');
                    }),
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.values.last,
                    decoration: _inputDecoration(
                      "Email Address",
                      Icons.email_outlined,
                    ),
                    validator: (value) {
                      if (value != null && !value.contains('@')) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    onSaved: ((value) {
                      print('Email Saved $value');
                    }),
                  ),

                  SizedBox(height: 20),

                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        phoneIcon = hasFocus ? Icons.telegram : Icons.phone;
                      });
                    },
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: _inputDecoration(
                        "Phone Number",
                        phoneIcon,
                      ).copyWith(prefixText: "+880  "),
                      validator: ((value) {
                        if (value != null && value.length < 11) {
                          return "Enter a valid phone number";
                        }
                      }),
                      onSaved: ((value) {
                        print('Phone Number Saved $value');
                      }),
                    ),
                  ),

                  SizedBox(height: 10),
                  Divider(height: 30),
                  Text(
                    "Security",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    obscureText: !_isPasswordVisible,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    decoration: _inputDecoration("Password", Icons.lock_outline)
                        .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          helperText: "Must be at least 8 characters",
                        ),
                    validator: (value) {
                      if (value != null && value.length < 8) {
                        return "Password too short";
                      }
                      return null;
                    },
                    onSaved: ((value) {
                      print('Password Saved $value');
                    }),
                  ),

                  SizedBox(height: 30),

                  // Text(
                  //   "Bio",
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(height: 10),
                  //
                  // // 5. MULTI-LINE FIELD (TextArea)
                  // // Shows: maxLines, alignsLabelWithHint
                  // TextFormField(
                  //   maxLines: 4, // Makes it a box
                  //   decoration: InputDecoration(
                  //     hintText: "Tell us about yourself...",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     filled: true,
                  //     fillColor: Colors.grey[50],
                  //   ),
                  // ),
                  SizedBox(height: 40),

                  // SUBMIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Profile Updated for ${_nameController.text}!",
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Save Changes",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ), // Lighter border when not focused
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 2,
        ), // Thick blue border when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
