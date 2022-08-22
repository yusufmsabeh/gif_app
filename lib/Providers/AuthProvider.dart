import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Helpers/AuthHelper.dart';
import 'package:gif_app/Helpers/DioHelper.dart';
import 'package:gif_app/Model/AppUser.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:gif_app/Screens/Homepage.dart';
import 'package:gif_app/Screens/SignupSigninScreen.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();
  TextEditingController resetPasswordContoller = TextEditingController();

  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  TextEditingController userNameSignUpController = TextEditingController();

  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>();

  bool isLoading = false;

  SignIn() async {
    ChangeLoadingState();
    if (signInKey.currentState!.validate()) {
      UserCredential? credential = await AuthHelper.instance
          .SignIn(emailSignInController.text, passwordSignInController.text);
      if (credential != null) {
        Provider.of<FireStoreProvider>(AppRouter.navKey.currentContext!,
                listen: false)
            .getUser();
        emailSignInController.clear();
        passwordSignInController.clear();
        AppRouter.pushWithReplacment(HomePage());
      }
    }
    ChangeLoadingState();
  }

  SignUp() async {
    ChangeLoadingState();

    if (signUpKey.currentState!.validate()) {
      UserCredential? credential = await AuthHelper.instance
          .SignUp(emailSignUpController.text, passwordSignUpController.text);
      if (credential != null) {
        AppUser appUser = AppUser(
            id: credential.user!.uid,
            email: credential.user!.email,
            username: userNameSignUpController.text);
        await Provider.of<FireStoreProvider>(AppRouter.navKey.currentContext!,
                listen: false)
            .saveUser(appUser);
        emailSignUpController.clear();
        passwordSignUpController.clear();
        userNameSignUpController.clear();
        Provider.of<UIProvider>(AppRouter.navKey.currentContext!, listen: false)
            .changeSigInUpPage(0);
      }
    }
    log("the app still working");
    ChangeLoadingState();
  }

  SignOut() async {
    Provider.of<FireStoreProvider>(AppRouter.navKey.currentContext!,
            listen: false)
        .clearFavorites();
    await AuthHelper.instance.SignOut();
    AppRouter.pushWithReplacment(SignupSigninScreen());
  }

  ResetPassword() async {
    if (resetPasswordKey.currentState!.validate()) {
      await AuthHelper.instance.ResetPassword(resetPasswordContoller.text);
      resetPasswordContoller.clear();
      AppRouter.popWidget();
    }
  }

  User? getCurrentUser() {
    return AuthHelper.instance.getUser();
  }

  ChangeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
