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
  @override
  String toString() {
    // TODO: implement toString
    return '--$id--';
  }
}
