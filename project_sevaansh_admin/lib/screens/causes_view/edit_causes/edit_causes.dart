import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_sevaansh_admin/constants/constants.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:project_sevaansh_admin/models/category_models/category_model.dart';
import 'package:project_sevaansh_admin/models/product_models/product_model.dart';
import 'package:project_sevaansh_admin/models/user_models/user_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
// import 'package:project_sevaansh_admin/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class EditCause extends StatefulWidget {
  final CauseModel productModel;
  final int index;
  const EditCause({super.key, required this.productModel, required this.index});

  @override
  State<EditCause> createState() => _EditCauseState();
}

class _EditCauseState extends State<EditCause> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Causes",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? widget.productModel.image.isNotEmpty
                  ? CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            NetworkImage(widget.productModel.image),
                      ),
                    )
                  : CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: const CircleAvatar(
                        radius: 55,
                        child: Icon(Icons.camera_alt),
                      ),
                    )
              : CupertinoButton(
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                  ),
                  onPressed: () {
                    takePicture();
                  }),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: widget.productModel.name,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: description,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: widget.productModel.description,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            child: const Text('Update'),
            onPressed: () async {
              if (image == null && name.text.isEmpty && description.text.isEmpty) {
                Navigator.of(context).pop();
              } else if (image != null) {
                String imageURL = await FirebaseStorageHelper.instance
                    .uploadUserImage(widget.productModel.id, image!);
                CauseModel productModel = widget.productModel.copyWith(
                  description:
                      description.text.isEmpty ? null : description.text,
                  image: imageURL,
                  name: name.text.isEmpty ? null : name.text,
                );
                appProvider.updateCauseList(widget.index, productModel);
                showMessage('Update Successfully');
              } else {
                CauseModel productModel = widget.productModel.copyWith(
                  description:
                      description.text.isEmpty ? null : description.text,
                  name: name.text.isEmpty ? null : name.text,
                );
                appProvider.updateCauseList(widget.index, productModel);

                showMessage('Update Successfully');
              }
            },
          ),
        ],
      ),
    );
  }
}
