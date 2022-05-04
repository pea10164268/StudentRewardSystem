import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_reward_system/Screens/User/ForgotPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Sign in',
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
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                          controller: passwordController,
                          obscureText: true,
                          autocorrect: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                UserCredential userCredential =
                                    await _auth.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                Navigator.popAndPushNamed(context, '/profile');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Sign In',
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
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                  context, '/password/reset');
                            },
                            child: const Text('Forgot Password?',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(height: 30),
                        const Text('Don\'t have an account?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/register');
                            },
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ],
                    )))));
  }
}
