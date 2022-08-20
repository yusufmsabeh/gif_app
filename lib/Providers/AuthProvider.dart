import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Helpers/AuthHelper.dart';
import 'package:gif_app/Model/AppUser.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:gif_app/Screens/Homepage.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailSignInController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();

  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  TextEditingController userNameSignUpController = TextEditingController();

  SignIn() async {
    await AuthHelper.instance
        .SignIn(emailSignInController.text, passwordSignInController.text);
    emailSignInController.clear();
    passwordSignInController.clear();
    AppRouter.pushWithReplacment(HomePage());
  }

  SignUp() async {
    UserCredential credential = await AuthHelper.instance
        .SignUp(emailSignUpController.text, passwordSignUpController.text);
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

  User? getCurrentUser() {
    return AuthHelper.instance.getUser();
  }
}
