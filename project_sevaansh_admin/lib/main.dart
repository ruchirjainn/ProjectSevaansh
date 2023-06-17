import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_sevaansh_admin/constants/theme.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_options/firebase_option.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/home_page/home_page.dart';
import 'package:project_sevaansh_admin/screens/login_screen/login_screen.dart';
import 'package:project_sevaansh_admin/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Admin Panel',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const SplashScreen(),
      ),
    );
  }
}
