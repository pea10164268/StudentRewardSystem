import 'package:flutter/material.dart';

class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({Key? key}) : super(key: key);

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: (MediaQuery.of(context).size.width),
      height: (MediaQuery.of(context).size.height),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Registration Successful!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Text('Redirect to login screen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    ));
  }
}
