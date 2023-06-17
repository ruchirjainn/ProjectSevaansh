import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh/constants/constants.dart';
import 'package:project_sevaansh/constants/routes.dart';
import 'package:project_sevaansh/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:project_sevaansh/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:project_sevaansh/homepage/home.dart';
import 'package:project_sevaansh/widgets/primary_button/primary_button.dart';
import 'package:project_sevaansh/widgets/top_titles/top_titles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const TopTitles(
                title: "Create Account", subtitle: "Project Sevaansh"),
            const SizedBox(
              height: 40.0,
            ),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.person_outline,
                  )),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email,
                  )),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  hintText: "Phone",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  )),
            ),
            const SizedBox(
              height: 20.0,
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
              height: 40.0,
            ),
            PrimaryButton(
              title: "Create an account",
              onPressed: () async {
                bool isValidate = signUpValidation(
                    email.text, password.text, name.text, phone.text);
                print(isValidate);
                if (isValidate) {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .signUp(name.text, email.text, password.text, context);
                  print(isLogined);

                  if (isLogined) {
                    Routes.instance.pushAndRemoveUntil(
                        widget: const CustomBottomBar(), context: context);
                  }
                }
              },
            ),
            const SizedBox(
              height: 36.0,
            ),
            Center(
                child: Text(
              "I've already an account?",
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
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Login",
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
