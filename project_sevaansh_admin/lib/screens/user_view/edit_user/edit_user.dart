import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_sevaansh_admin/constants/constants.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:project_sevaansh_admin/models/user_models/user_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
// import 'package:project_sevaansh_admin/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const EditUser({super.key, required this.userModel, required this.index});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController name = TextEditingController();

  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  // TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                      radius: 55, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: widget.userModel.name,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            child: const Text('Update'),
            onPressed: () async {
              if (image == null && name.text.isEmpty) {
                Navigator.of(context).pop();
              } else if (image != null) {
                // print('hello1');
                String imageURL = await FirebaseStorageHelper.instance
                    .uploadUserImage(widget.userModel.id, image!);
                UserModel userModel = widget.userModel.copyWith(
                  image: imageURL,
                  name: name.text.isEmpty ? null : name.text,
                );
                appProvider.updateUserList(widget.index, userModel);
                showMessage('Update Successfully');
              } else {
                UserModel userModel = widget.userModel.copyWith(
                  name: name.text.isEmpty ? null : name.text,
                );
                appProvider.updateUserList(widget.index, userModel);
                showMessage('Update Successfully');
              }
              // Navigator.of(context).pop();
              // UserModel userModel = appProvider.getUserInformation
              //     .copyWith(name: textEditingController.text);
              // appProvider.updateUserInfoFirebase(context, userModel, image);
            },
          ),
        ],
      ),
    );
  }
}
