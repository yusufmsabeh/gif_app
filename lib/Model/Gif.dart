import 'dart:developer';

import 'package:gif_app/Model/AppUserGif.dart';

class AppGif {
  String? id;
  String? title;
  String? url;
  String? rating;
  AppUserGif? appUser;
  AppGif(
      {required this.id,
      required this.title,
      required this.url,
      required this.appUser,
      required this.rating});
  AppGif.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    rating = json['rating'];
    url = json['images']['fixed_height_downsampled']['url'];
    appUser = AppUserGif.fromJson(json['user']);
  }
  AppGif.fromFirebaseJson(Map<String, dynamic> json) {
    id = json['id'] ?? '1';
    title = json['title'] ?? 'no title';
    rating = json['rating'] ?? 'me';
    url = json['url'] ?? 'no url';
    appUser = AppUserGif.fromFirebaseJson(json['user']);
  }

  toMap() => {
        'id': id,
        'title': title,
        "url": url,
        'rating': 'Me',
        'user': appUser!.toJson()
      };
  @override
  String toString() {
    // TODO: implement toString
    return '--$id--';
  }
}
