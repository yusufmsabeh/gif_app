import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Helpers/FireStoreHelper.dart';
import 'package:gif_app/Model/AppUser.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class FireStoreProvider extends ChangeNotifier {
  AppUser? appUser;
  FireStoreProvider() {
    getUser();
  }
  saveUser(AppUser appUser) async {
    await FireStoreHelper.instance.saveUser(appUser);
  }

  getUser() async {
    User? user = Provider.of<AuthProvider>(AppRouter.navKey.currentContext!)
        .getCurrentUser();
    appUser = await FireStoreHelper.instance.getUser(user!.uid);
  }
}
