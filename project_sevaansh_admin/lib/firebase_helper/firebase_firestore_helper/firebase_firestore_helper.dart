import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_sevaansh_admin/constants/constants.dart';
import 'package:project_sevaansh_admin/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:project_sevaansh_admin/models/category_models/category_model.dart';
import 'package:project_sevaansh_admin/models/product_models/product_model.dart';
import 'package:project_sevaansh_admin/models/user_models/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<UserModel>> getUserList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleUser(String id) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(id)
          .delete(); //firebase se delete hogaya
      return 'Deleted Successfully';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userModel.id)
          .update(userModel.toJson()); //firebase se delete hogaya
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> deleteSingleCategory(String id) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(id)
          .delete(); //firebase se delete hogaya
      return 'Deleted Successfully';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleCateogory(CategoryModel categoryModel) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<CategoryModel> addSingleCateogory(File image, String name) async {
    DocumentReference reference =
        _firebaseFirestore.collection('categories').doc();
    String imageURL = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    CategoryModel addCategory = CategoryModel(
      image: imageURL,
      id: reference.id,
      name: name,
    );
    await reference.set(addCategory.toJson());
    return addCategory;
  }

  // Causes
  Future<List<CauseModel>> getCauses() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup('opportunities').get();
    List<CauseModel> productList =
        querySnapshot.docs.map((e) => CauseModel.fromJson(e.data())).toList();
    return productList;
  }

  Future<String> deleteCause(String categoryId, String causeId) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(categoryId)
          .collection('opportunities')
          .doc(causeId)
          .delete(); //firebase se delete hogaya
      return 'Deleted Successfully';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleCause(CauseModel causeModel) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(causeModel.categoryId)
          .collection('opportunities')
          .doc(causeModel.id)
          .update(causeModel.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<CauseModel> addSingleCause(
    File image,
    String name,
    String description,
    String categoryId,
    // String id,
  ) async {
    DocumentReference reference = _firebaseFirestore
        .collection('categories')
        .doc(categoryId)
        .collection('opportunities')
        .doc();
    String imageURL = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    CauseModel addCause = CauseModel(
      image: imageURL,
      id: reference.id,
      name: name,
      categoryId: categoryId,
      description: description,
    );
    await reference.set(addCause.toJson());
    return addCause;
  }
}
