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
        appBar: AppBar(
          title: const Text('Add Class',
              style: TextStyle(
                fontSize: 30,
              )),
          centerTitle: true,
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
                      autocorrect: true,
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
                      autocorrect: true,
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
                      autocorrect: true,
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing')),
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
                              horizontal: 30, vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                  ]),
                ))));
  }
}
