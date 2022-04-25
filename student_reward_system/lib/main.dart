import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/Class/class_create_screen.dart';
import 'Screens/Class/class_screen.dart';
import 'Screens/Student/add_student_screen.dart';
import 'Screens/Student/students_screen.dart';
import 'Screens/Teacher/add_teacher_screen.dart';
import 'Screens/Teacher/teachers_screen.dart';
import 'Screens/User/login_screen.dart';
import 'Screens/User/register_screen.dart';
import 'Screens/User/register_success.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('Student Reward System'),
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.green,
      ),
      initialRoute: '/teacher',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/register/success': (context) => const RegisterSuccess(),
        '/student': (context) => const Students(),
        '/student/add': (context) => const AddStudent(),
        '/teacher': (context) => const Teachers(),
        '/teacher/add': (context) => const AddTeacher(),
        '/class': (context) => const Class(),
        '/class/add': (context) => const CreateClass(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
