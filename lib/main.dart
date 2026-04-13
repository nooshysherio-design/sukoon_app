import 'package:flutter/material.dart';
import 'package:sukoon_app/Signin.dart';
import 'package:sukoon_app/therapist_form.dart';
import 'package:sukoon_app/therapist_signin.dart';
import 'package:sukoon_app/therapist_signup.dart';
import 'package:sukoon_app/therapists.dart';
import 'package:sukoon_app/userhome.dart';
import 'Signup.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SukoonHomePage(),
    );
  }
}
