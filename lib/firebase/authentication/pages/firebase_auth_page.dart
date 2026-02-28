import 'package:flutter/material.dart';
import 'package:flutter_basics_1/firebase/authentication/viewmodel/firebase_auth_viewmodel.dart';

class FirebaseAuthPage extends StatefulWidget {
  FirebaseAuthPage({super.key});

  @override
  State<FirebaseAuthPage> createState() => _FirebaseAuthPageState();
}

class _FirebaseAuthPageState extends State<FirebaseAuthPage> {
  final viewModel = FirebaseAuthViewmodel();

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  late String? email;

  late String? password;

  late String? username;

  bool isLogin = true;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Auth'), centerTitle: true),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin ? 'Login' : 'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                if (!isLogin)
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) => viewModel.validateUsername(value),
                    onSaved: (value) => username = _usernameController.text,
                  ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => viewModel.validateEmail(value),
                  onSaved: (value) => email = _emailController.text,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => viewModel.validatePassword(value),
                  onSaved: (value) => password = _passwordController.text,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();
                    if (isLogin) {
                      viewModel.logInWithEmail(email!, password!);
                    } else {
                      viewModel.signUpWithEmail(email!, password!, username!);
                    }
                  },
                  child: Text(isLogin ? 'Login' : 'Sign Up'),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: InkWell(
                    onTap: () {
                      viewModel.loginWithGoogle();
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/google.png', height: 30),
                        Text('Continue with Facebook'),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => isLogin = !isLogin),
                  child: Text(
                    isLogin
                        ? "Don't have an account? Sign Up."
                        : 'Already have an account? Login.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
