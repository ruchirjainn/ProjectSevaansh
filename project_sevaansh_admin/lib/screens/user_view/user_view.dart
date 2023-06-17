import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh_admin/models/user_models/user_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/user_view/widgets/single_user_view.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User View',
          style: GoogleFonts.lora(
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: value.getUserList.length,
            itemBuilder: (context, index) {
              UserModel userModel = value.getUserList[index];
              return SingleUserView(index: index, userModel: userModel);
            },
          );
        },
      ),
    );
  }
}
