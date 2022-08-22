import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gif_app/Model/AppUser.dart';
import 'package:gif_app/Model/Gif.dart';

class FireStoreHelper {
  static FireStoreHelper instance = FireStoreHelper._();
  FireStoreHelper._();

  saveUser(AppUser appUser) async {
    await FirebaseFirestore.instance
        .collection(AppUserFileds.collectionName)
        .doc(appUser.id)
        .set(appUser.toJson());
  }

  getUser(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection(AppUserFileds.collectionName)
            .doc(id)
            .get();
    AppUser appUser = AppUser.fromJson(documentSnapshot.data()!);
    appUser.id = id;
    return appUser;
  }

  updateUser(AppUser appUser) async {
    await FirebaseFirestore.instance
        .collection(AppUserFileds.collectionName)
        .doc(appUser.id)
        .update(appUser.toJson());
  }
}
