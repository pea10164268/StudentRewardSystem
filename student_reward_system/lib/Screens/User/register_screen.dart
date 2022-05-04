import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Screens/User/register_success.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _conPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Sign up',
              style: TextStyle(
                fontSize: 30,
              )),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
            child: Container(
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height),
                padding: const EdgeInsets.all(32),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email Address*',
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email Address.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password*',
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _conPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password*',
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your confirm password.';
                            } else if (_conPassword.text != _password.text) {
                              return 'The password and confirmation password do not match.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterSuccess()),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak');
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        const SizedBox(height: 30),
                        const Text('Already have an account?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/login');
                            },
                            child: const Text('Sign In',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ],
                    )))));
  }
}
