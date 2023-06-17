import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh_admin/constants/routes.dart';
import 'package:project_sevaansh_admin/models/user_models/user_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/user_view/edit_user/edit_user.dart';
import 'package:provider/provider.dart';

class SingleUserView extends StatefulWidget {
  final UserModel userModel;
  final int index;
  // final AppProvider appProvider;
  const SingleUserView(
      {super.key, required this.userModel, required this.index});

  @override
  State<SingleUserView> createState() => _SingleUserViewState();
}

class _SingleUserViewState extends State<SingleUserView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            widget.userModel.image != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(widget.userModel.image!),
                    // child: Image.network(widget.userModel.image!),
                  )
                : const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userModel.name,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  widget.userModel.email,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            isLoading
                ? const CircularProgressIndicator()
                : GestureDetector(
                    // padding: EdgeInsets.zero,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appProvider
                          .deleteUserFromFirebase(widget.userModel);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              // padding: EdgeInsets.zero,
              onTap: () async {
                Routes.instance.push(
                    widget: EditUser(
                        index: widget.index, userModel: widget.userModel),
                    context: context);
              },
              child: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
