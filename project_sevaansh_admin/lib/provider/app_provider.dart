import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_sevaansh_admin/constants/constants.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:project_sevaansh_admin/models/category_models/category_model.dart';
import 'package:project_sevaansh_admin/models/product_models/product_model.dart';
import 'package:project_sevaansh_admin/models/user_models/user_model.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoryModel> _categoriesList = [];
  List<CauseModel> _causeList = [];

  Future<void> getUserListFun() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
  }

  Future<void> getCategoriesListFun() async {
    _categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
  }

  Future<void> deleteUserFromFirebase(UserModel userModel) async {
    notifyListeners();

    String value =
        await FirebaseFirestoreHelper.instance.deleteSingleUser(userModel.id);
    if (value == "Deleted Successfully") {
      _userList.remove(userModel);
      showMessage('Deleted Successfully');
    }

    notifyListeners();
  }

  List<UserModel> get getUserList => _userList;
  List<CategoryModel> get getCategoriesList => _categoriesList;
  List<CauseModel> get getCauses => _causeList;

  Future<void> callbakFunction() async {
    await getUserListFun();
    await getCategoriesListFun();
    await getCause();
  }

  void updateUserList(int index, UserModel userModel) async {
    await FirebaseFirestoreHelper.instance.updateUser(userModel);
    //  int index=_userList.indexOf(userModel);
    _userList[index] = userModel;
    notifyListeners();
  }

  // category fucntion
  Future<void> deleteCategoryFromFirebase(CategoryModel categoryModel) async {
    String value = await FirebaseFirestoreHelper.instance
        .deleteSingleCategory(categoryModel.id);
    if (value == "Deleted Successfully") {
      _categoriesList.remove(categoryModel);
      showMessage('Deleted Successfully');
    }

    notifyListeners();
  }

  void updateCategoryList(int index, CategoryModel categoryModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleCateogory(categoryModel);
    _categoriesList[index] = categoryModel;
    notifyListeners();
  }

  void addCategory(File image, String name) async {
    CategoryModel categoryModel =
        await FirebaseFirestoreHelper.instance.addSingleCateogory(image, name);
    _categoriesList.add(categoryModel);
    notifyListeners();
  }

  Future<void> getCause() async {
    _causeList = await FirebaseFirestoreHelper.instance.getCauses();
    notifyListeners();
  }

  Future<void> deleteCauseFromFirebase(CauseModel productModel) async {
    String value = await FirebaseFirestoreHelper.instance
        .deleteCause(productModel.categoryId, productModel.id);
    if (value == "Deleted Successfully") {
      _causeList.remove(productModel);
      showMessage('Deleted Successfully');
    }

    notifyListeners();
  }

  void updateCauseList(int index, CauseModel causeModel) async {
    await FirebaseFirestoreHelper.instance.updateSingleCause(causeModel);
    _causeList[index] = causeModel;
    notifyListeners();
  }

  void addCause(
    File image,
    String name,
    String description,
    String categoryId,
    // String id,
  ) async {
    CauseModel productModel = await FirebaseFirestoreHelper.instance
        .addSingleCause(image, name, description, categoryId);
    _causeList.add(productModel);
    notifyListeners();
  }
}
