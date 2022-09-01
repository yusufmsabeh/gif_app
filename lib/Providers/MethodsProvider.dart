import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:provider/provider.dart';

class MethodProvider {
  checkFavotites(String id) {
    return Provider.of<FireStoreProvider>(AppRouter.navKey.currentContext!)
        .appUser!
        .favorites
        .contains(id);
  }

  passwordValidate(String? value) {
    if (value == null || value.length == 0) return "Required".tr();
    if (value.length < 6) return "WeekPassword".tr();
  }

  emailValidate(String? value) {
    if (value == null || value.length == 0) return "Required".tr();
    if (!value.contains('@') || !value.contains('.com'))
      return "InvalidEmail".tr();
  }

  userNameValidate(String? value) {
    if (value == null || value.length == 0) return "Required".tr();
  }

  copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ShowSnackBar("Copied");
  }

  ShowSnackBar(String text) {
    ScaffoldMessenger.of(AppRouter.navKey.currentContext!)
        .showSnackBar(SnackBar(content: Text(text)));
  }
}
