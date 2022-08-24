import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Helpers/DioHelper.dart';
import 'package:gif_app/Helpers/FireStoreHelper.dart';
import 'package:gif_app/Model/AppUser.dart';
import 'package:gif_app/Model/AppUserGif.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:provider/provider.dart';

import '../Model/Gif.dart';

class FireStoreProvider extends ChangeNotifier {
  AppUser? appUser;
  List<AppGif> favoritesGif = [];
  List<AppGif> MyGif = [];
  bool isLoading = false;

  File? selectedImage;
  TextEditingController gifTitle = TextEditingController();

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

  uploadGif() async {
    changeLoadingState();
    String fileUrl = await uplaodFile();
    AppGif appGif = AppGif(
        id: '',
        title: gifTitle.text,
        url: fileUrl,
        appUser: AppUserGif(avatarUrl: '', userName: appUser!.username),
        rating: 'me');
    await FireStoreHelper.instance.uploadGif(appGif, appUser!.id!);
    changeLoadingState();
    gifTitle.clear();
  }

  uplaodFile() async {
    return await FireStoreHelper.instance.uplaodFile(selectedImage!);
  }

  getImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['gif']);
    selectedImage = File(result!.files.first.path ?? '');
    notifyListeners();
  }

  getMyGifs() async {
    MyGif = await FireStoreHelper.instance.getMyGif(appUser!.id!);
    notifyListeners();
  }
}
