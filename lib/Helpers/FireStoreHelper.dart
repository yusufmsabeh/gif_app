import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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

  uploadGif(AppGif appGif, String uid) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('gifs')
        .add(appGif.toMap());
  }

  Future<List<AppGif>> getMyGif(String uid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('user')
        .doc(uid)
        .collection('gifs')
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocumentSnapshot =
        querySnapshot.docs;

    List<AppGif> gifs = [];
    queryDocumentSnapshot.forEach(
      (element) {
        AppGif gif = AppGif.fromFirebaseJson(element.data());
        gif.id = element.id;

        gifs.add(gif);
      },
    );
    print(gifs);
    return gifs;
  }

  uplaodFile(File file, String UserId) async {
    String fileName = file.path.split('/').last;
    Reference reference =
        FirebaseStorage.instance.ref("$UserId/gifs/$fileName");

    TaskSnapshot uploadTask = await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  deleteGif(gifId, userId) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection('gifs')
        .doc(gifId)
        .delete();
  }
}
