// ignore_for_file: file_names

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
  List favorites = [];
  AppUser({
    required this.id,
    required this.username,
    required this.email,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    username = json[AppUserFileds.userName] as String;
    email = json[AppUserFileds.email] as String;

    favorites = json[AppUserFileds.favorites];
  }

  toJson() => {
        AppUserFileds.userName: username,
        AppUserFileds.email: email,
        AppUserFileds.favorites: favorites,
      };
}
