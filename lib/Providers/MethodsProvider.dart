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
    if (value == null || value.length == 0) return "This valid is required";
    if (value.length < 6) return "Week Password";
  }

  emailValidate(String? value) {
    if (value == null || value.length == 0) return 'This valid is required';
    if (!value.contains('@') || !value.contains('.com')) return "Invalid Email";
  }

  userNameValidate(String? value) {
    if (value == null || value.length == 0) return 'This valid is required';
  }
}
