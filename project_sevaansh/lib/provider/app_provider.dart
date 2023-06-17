import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_sevaansh/constants/constants.dart';
import 'package:project_sevaansh/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:project_sevaansh/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:project_sevaansh/models/product_models/product_model.dart';
import 'package:project_sevaansh/models/user_models/user_model.dart';

class AppProvider with ChangeNotifier {
  final List<ProductModel> _cartProductList = [];

  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;

  // CART WORK
  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  // // FAVORITE
  // List<ProductModel> _favoriteProductList = [];

  // // CART WORK
  // void addFavoriteProduct(ProductModel productModel) {
  //   _favoriteProductList.add(productModel);
  //   notifyListeners();
  // }

  // void removeFavoriteProduct(ProductModel productModel) {
  //   _favoriteProductList.remove(productModel);
  //   notifyListeners();
  // }

  // List<ProductModel> get getFavoriteProductList => _favoriteProductList;

  // User Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      //image nahi dala
      showLoaderDialog(context);
      _userModel = userModel;

      FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      notifyListeners();
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("Successfully Updated Profile!");
    notifyListeners();
  }
}
