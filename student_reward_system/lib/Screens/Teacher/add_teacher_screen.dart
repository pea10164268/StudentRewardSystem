import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController classController = TextEditingController();

  CollectionReference teachers =
      FirebaseFirestore.instance.collection('teachers');

  Future<void> addTeacher() {
    return teachers
        .add({
          'first_name': fNameController.text,
          'last_name': lNameController.text,
          'class': classController.text
        })
        .then((value) => print("Teacher Added"))
        .catchError((error) => print("Failed to add teacher: $error"));
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
          title: const Text('Add Teacher',
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
                            return 'Please enter your Class ID.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addTeacher();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Teacher Added!')),
                            );
                          }
                        },
                        child: const Text(
                          'Add Teacher',
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
                  ))),
        ));
  }
}
