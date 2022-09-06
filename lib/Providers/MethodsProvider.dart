import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Model/Gif.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

  downloadFile(AppGif appGif) async {
    AppRouter.showSnackBar("Downloading....");
    await Permission.storage.request();
    final uri = Uri.parse(appGif.originalUrl ?? '');
    final response = await http.get(uri);
    final bytes = response.bodyBytes;
    Directory directory = Directory('/storage/emulated/0/Download');

    final String path = '${directory.path}/${appGif.title}.gif';
    File(path).writeAsBytesSync(bytes);
    AppRouter.showSnackBar("Downloaded successfully ");
  }
}
