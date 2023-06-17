import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh/constants/constants.dart';
import 'package:project_sevaansh/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:project_sevaansh/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:project_sevaansh/screens/auth_ui/sign_up/sign_up.dart';
import 'package:project_sevaansh/widgets/primary_button/primary_button.dart';
import 'package:project_sevaansh/widgets/top_titles/top_titles.dart';
import 'package:project_sevaansh/constants/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const TopTitles(title: "Login", subtitle: "Project Sevaansh"),
            const SizedBox(
              height: 40.0,
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email,
                  )),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: password,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                  )),
            ),
            const SizedBox(
              height: 50.0,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () async {
                bool isValidate = loginValidation(email.text, password.text);
                if (isValidate) {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .login(email.text, password.text, context);
                  if (isLogined) {
                    Routes.instance.pushAndRemoveUntil(
                        widget: const CustomBottomBar(), context: context);
                  }
                }
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
                child: Text(
              "Don't have an account?",
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            )),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  Routes.instance
                      .push(widget: const SignUp(), context: context);
                },
                child: Text(
                  "Create an account",
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
