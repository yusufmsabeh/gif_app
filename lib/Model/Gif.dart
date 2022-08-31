import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:gif_app/Model/AppUserGif.dart';

class AppGif {
  String? id;
  String? title;
  String? fixedUrl;
  String? originalUrl;
  String? rating;
  AppUserGif? appUser;

  bool? isMyGif;

  AppGif({
    required this.id,
    required this.title,
    required this.fixedUrl,
    required this.appUser,
    required this.rating,
    required this.isMyGif,
    required this.originalUrl,
  });
  AppGif.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    rating = json['rating'];
    fixedUrl = json['images']['downsized_still']['url'];
    originalUrl = json['images']['original']['url'];
    appUser = AppUserGif.fromJson(json['user']);

    isMyGif = false;
  }
  AppGif.fromFirebaseJson(Map<String, dynamic> json) {
    id = json['id'] ?? '1';
    title = json['title'] ?? 'no title';
    rating = json['rating'] ?? 'me';
    fixedUrl = json['url'] ?? 'no url';

    appUser = AppUserGif.fromFirebaseJson(json['user']);
    isMyGif = true;
  }

  toMap() => {
        'id': id,
        'title': title,
        "fixedUrl": fixedUrl,
        "originalUrl": originalUrl,
        'rating': 'Me',
        'user': appUser!.toJson()
      };
  @override
  String toString() {
    // TODO: implement toString
    return '--$id--';
  }
}
