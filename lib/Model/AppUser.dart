import 'package:gif_app/Model/Gif.dart';

class AppUserFileds {
  static const String collectionName = 'user';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String favorites = 'favorites';
}

class AppUser {
  String? id;
  String? username;
  String? email;
  List<AppGif> favorites = [];
  AppUser({
    required this.id,
    required this.username,
    required this.email,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    username = json[AppUserFileds.userName];
    email = json[AppUserFileds.email];
    List<Map<String, dynamic>> favoritesMap = json[AppUserFileds.favorites];
    favorites = favoritesMap.map((e) => AppGif.fromJson(e)).toList();
  }

  toJson() => {
        AppUserFileds.userName: username,
        AppUserFileds.email: email,
        AppUserFileds.favorites: favorites,
      };
}
