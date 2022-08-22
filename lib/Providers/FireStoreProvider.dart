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
  List<AppGif> favoritesGif = [];

  bool isLoading = false;

  FireStoreProvider() {
    getUser();
  }
  saveUser(AppUser appUser) async {
    await FireStoreHelper.instance.saveUser(appUser);
  }

  getUser() async {
    User? user = Provider.of<AuthProvider>(AppRouter.navKey.currentContext!,
            listen: false)
        .getCurrentUser();
    log(user!.uid);
    appUser = await FireStoreHelper.instance.getUser(user.uid);
  }

  addOrDeleteFavorites(String id) {
    changeLoadingState();
    if (appUser!.favorites.any((element) => element == id)) {
      appUser!.favorites.remove(id);
    } else {
      appUser!.favorites.add(id);
    }
    FireStoreHelper.instance.updateUser(appUser!);
    fillFavoritesGif();
    notifyListeners();
    changeLoadingState();
  }

  checkFavotites(String id) {
    return appUser!.favorites.contains(id);
  }

  fillFavoritesGif() async {
    changeLoadingState();

    favoritesGif = await Provider.of<DioProvider>(
            AppRouter.navKey.currentContext!,
            listen: false)
        .getGifByIds(appUser!.favorites);
    notifyListeners();
    changeLoadingState();
  }

  clearFavorites() {
    favoritesGif.clear();
    notifyListeners();
  }

  changeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
