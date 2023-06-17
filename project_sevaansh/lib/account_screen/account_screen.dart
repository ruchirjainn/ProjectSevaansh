import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh/constants/routes.dart';
// import 'package:project_sevaansh/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:project_sevaansh/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:project_sevaansh/homepage/home.dart';
import 'package:project_sevaansh/profile_edit/profile_edit.dart';
import 'package:project_sevaansh/provider/app_provider.dart';
import 'package:project_sevaansh/screens/about_us/about_us.dart';
import 'package:project_sevaansh/screens/password_change/password_change.dart';
import 'package:project_sevaansh/screens/support/support.dart';
import 'package:project_sevaansh/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: const Text(
      //     "Account",
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 60,
                      ),
                // const Icon(
                //   Icons.person_outline,
                //   size: 120,
                // ),
                Text(
                  appProvider.getUserInformation.name,
                  // "Ruchur",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  appProvider.getUserInformation.email,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // "ruchir",
                ),
                const SizedBox(
                  height: 11.0,
                ),
                SizedBox(
                  width: 130,
                  child: PrimaryButton(
                    title: "Edit Profile",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const EditProfile(), context: context);
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const Home(), context: context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Donation"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const AboutUs(), context: context);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const ChangePassword(), context: context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const SupportScreen(), context: context);
                  },
                  leading: const Icon(Icons.support_outlined),
                  title: const Text("Support"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();
                    setState(() {});
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text(
                    "Log out",
                  ),
                ),
                const SizedBox(
                  height: 98.0,
                ),
                Text(
                  "© 2023 Project Sevaansh. All rights reserved.",
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
