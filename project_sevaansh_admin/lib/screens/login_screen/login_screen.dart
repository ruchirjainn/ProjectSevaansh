import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_sevaansh_admin/constants/assets_images.dart';
import 'package:project_sevaansh_admin/constants/constants.dart';
import 'package:project_sevaansh_admin/decoration/primary_button/primary_button.dart';
import 'package:project_sevaansh_admin/decoration/top_titles/top_titles.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

import 'package:project_sevaansh_admin/constants/theme.dart';
import 'package:project_sevaansh_admin/constants/routes.dart';
import 'package:project_sevaansh_admin/screens/home_page/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

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
            const TopTitles(
                title: "Project Sevaansh", subtitle: "Hello! Admin"),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              height: 250,
              child: const Center(
                child: Image(
                  image: NetworkImage('https://i.pinimg.com/736x/f4/b0/85/f4b0855ba9187abc4066652a7f1647b7.jpg'),
                )
              ),
            ),
            const SizedBox(height: 30.0),
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
              height: 40.0,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () async {
                bool isValidate = loginValidation(email.text, password.text);
                if (isValidate) {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .login(email.text, password.text, context);
                  if (isLogined) {
                    // ignore: use_build_context_synchronously
                    Routes.instance
                        .push(widget: const HomePage(), context: context);
                  }
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
