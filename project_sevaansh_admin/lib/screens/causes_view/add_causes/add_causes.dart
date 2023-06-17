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
import 'package:provider/provider.dart';

class AddCause extends StatefulWidget {
  const AddCause({super.key});

  @override
  State<AddCause> createState() => _AddCauseState();
}

class _AddCauseState extends State<AddCause> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  CategoryModel? _selectedCategory;

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
              ? CupertinoButton(
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
            decoration: const InputDecoration(
              hintText: 'Enter Cause Name',
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: description,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Enter Cause Description',
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.white),
            child: DropdownButtonFormField(
              value: _selectedCategory,
              isExpanded: true,
              hint: const Text(
                'Select Cause',
              ),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: appProvider.getCategoriesList.map((CategoryModel val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    val.name,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () async {
              if (image == null ||
                  _selectedCategory == null ||
                  name.text.isEmpty ||
                  description.text.isEmpty) {
                showMessage('Enter all the required fields');
              } else {
                appProvider.addCause(
                  image!,
                  name.text,
                  description.text,
                  _selectedCategory!.id,
                );
                showMessage('Added Successfully');
              }
            },
          ),
        ],
      ),
    );
  }
}
