import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Helpers/FireStoreHelper.dart';
import 'package:gif_app/Model/AppUser.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:provider/provider.dart';

import '../Model/Gif.dart';

class FireStoreProvider extends ChangeNotifier {
  AppUser? appUser;
  List<String> favoritesString = [];
  List<AppGif> favoritesGif = [];
  FireStoreProvider() {
    fillFavoritesGif();
    getUser();
  }
  saveUser(AppUser appUser) async {
    await FireStoreHelper.instance.saveUser(appUser);
  }

  getUser() async {
    User? user = Provider.of<AuthProvider>(AppRouter.navKey.currentContext!)
        .getCurrentUser();
    log(user!.uid);
    appUser = await FireStoreHelper.instance.getUser(user.uid);
  }

  addOrDeleteFavorites(String id) {
    if (appUser!.favorites.any((element) => element == id)) {
      appUser!.favorites.remove(id);
    } else {
      appUser!.favorites.add(id);
    }
    FireStoreHelper.instance.updateUser(appUser!);
    fillFavoritesGif();
    notifyListeners();
  }

  checkFavotites(String id) {
    return appUser!.favorites.contains(id);
  }

  fillFavoritesGif() async {
    favoritesGif = await Provider.of<DioProvider>(
            AppRouter.navKey.currentContext!,
            listen: false)
        .getGifByIds(appUser!.favorites);
    notifyListeners();
  }
}
