import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Forms/SignInForm.dart';
import 'package:gif_app/Forms/SignUpForm.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Screens/GifHomepage.dart';
import 'package:gif_app/Screens/Homepage.dart';
import 'package:gif_app/Screens/SignupSigninScreen.dart';
import 'package:gif_app/Screens/StaickerHomepage.dart';
import 'package:provider/provider.dart';

class UIProvider extends ChangeNotifier {
  int SignInUpIndex = 0;
  Widget currentWidget = SignInForm();

  int bottomNavigationBarIndex = 0;
  Widget bottomNavigationBarWidget = GifHomepage();
  changeSigInUpPage(Value) {
    SignInUpIndex = Value;
    currentWidget = SignInUpIndex == 0 ? SignInForm() : SignUpForm();
    notifyListeners();
  }

  changeBottomNavigationBarIndex(Value) {
    bottomNavigationBarIndex = Value;
    bottomNavigationBarWidget =
        bottomNavigationBarIndex == 0 ? GifHomepage() : StickerHomepage();
    notifyListeners();
  }

  HomePageController(var context) {
    User? user = Provider.of<AuthProvider>(context).getCurrentUser();

    if (user == null) {
      log("user is null");
      return SignupSigninScreen();
    } else
      return HomePage();
  }
}
