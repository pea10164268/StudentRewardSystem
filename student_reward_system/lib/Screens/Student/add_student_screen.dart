import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController classController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addStudent() {
    return students
        .add({
          'first_name': fNameController.text,
          'last_name': lNameController.text,
          'class': classController.text
        })
        .then((value) => print("Student Added"))
        .catchError((error) => print("Failed to add student: $error"));
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    classController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Student',
              style: TextStyle(
                fontSize: 30,
              )),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(children: [
          Container(
              padding: const EdgeInsets.all(32),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fNameController,
                        decoration: InputDecoration(
                            hintText: 'First Name*',
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: lNameController,
                        decoration: InputDecoration(
                            hintText: 'Last Name*',
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: classController,
                        decoration: InputDecoration(
                            hintText: 'Class ID*',
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill in address line 2.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addStudent();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Student added!')),
                            );
                          }
                        },
                        child: const Text(
                          'Add Student',
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
                    ],
                  )))
        ]));
  }
}
