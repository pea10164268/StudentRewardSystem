import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({Key? key}) : super(key: key);

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController classDescriptionController =
      TextEditingController();
  final TextEditingController teacherIDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CollectionReference classroom =
      FirebaseFirestore.instance.collection('classroom');

  Future<void> addClassroom() {
    return classroom
        .add({
          'first_name': classNameController.text,
          'last_name': classDescriptionController.text,
          'class': teacherIDController.text
        })
        .then((value) => print("Classroom Added"))
        .catchError((error) => print("Failed to add classroom: $error"));
  }

  @override
  void dispose() {
    classNameController.dispose();
    classDescriptionController.dispose();
    teacherIDController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Class',
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
                  child: Column(children: [
                    TextFormField(
                      controller: classNameController,
                      decoration: InputDecoration(
                          hintText: 'Class Name*',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in class name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: classDescriptionController,
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: 'Description*',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in the description.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: teacherIDController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Teacher ID*',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in teacher id.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addClassroom();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Classroom Added!')),
                          );
                        }
                      },
                      child: const Text(
                        'Add Class',
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
                  ]),
                ))));
  }
}
