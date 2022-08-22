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
}
