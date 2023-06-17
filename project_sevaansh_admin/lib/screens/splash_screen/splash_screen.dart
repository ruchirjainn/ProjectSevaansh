import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_sevaansh_admin/constants/assets_images.dart';
import 'package:project_sevaansh_admin/screens/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:
          Colors.white, // Set the background color to black for a dark theme
      body: Center(
        child: Image(
          image: NetworkImage(
              'https://images-platform.99static.com//pY-wS17PXmgc1Zaaa7jtftZydYw=/98x102:1290x1294/fit-in/590x590/99designs-contests-attachments/80/80168/attachment_80168289'),
        ),
      ),
    );
  }
}
