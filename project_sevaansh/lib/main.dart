import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:project_sevaansh/constants/theme.dart';
import 'package:project_sevaansh/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:project_sevaansh/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:project_sevaansh/provider/app_provider.dart';
import 'package:project_sevaansh/screens/auth_ui/welcome/welcome.dart';
import 'package:project_sevaansh/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey='pk_test_51NJA72SHNZYtBUp1SLFuDvMtlsw23OuYOyuRYL46uR3rfqAqdjzPsoNwqKW6zd0K1QVjM1I00JxcJSLcIMptVfZ900XONhxslH';
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Project Sevaansh',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: StreamBuilder(
          //if user is logged in and he exit and come aagin then also he is login
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
