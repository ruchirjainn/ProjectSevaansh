import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_sevaansh/constants/assets_images.dart';
import 'package:project_sevaansh/constants/routes.dart';
import 'package:project_sevaansh/screens/auth_ui/login/login.dart';
import 'package:project_sevaansh/screens/auth_ui/sign_up/sign_up.dart';
import 'package:project_sevaansh/widgets/primary_button/primary_button.dart';
import 'package:project_sevaansh/widgets/top_titles/top_titles.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const TopTitles(
                  title: "Welcome", subtitle: "Supporting Together, Impacting Forever"),
              const SizedBox(height: 35.0),
              Container(
                height: 250,
                child: Center(
                  child: Image.asset(AssetsImages.instance.bannerImage),
                ),
              ),
              const SizedBox(height: 30.0),
              PrimaryButton(
                title: "Login",
                onPressed: () {
                  Routes.instance.push(widget: const Login(), context: context);
                },
              ),
              const SizedBox(height: 26.0),
              PrimaryButton(
                title: "Sign Up",
                onPressed: () {
                  Routes.instance
                      .push(widget: const SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
