import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gif_app/Model/Gif.dart';

class DioHelper {
  DioHelper._();
  static DioHelper dioHelper = DioHelper._();
  Dio dio = Dio();
  getTrendingGif() async {
    Response response = await dio.get(
        'https://api.giphy.com/v1/gifs/trending?api_key=C3K4QIt7Onh1W85eE7jFoeyHCurqOEyz&limit=50&rating=g');
    List data = response.data['data'];
    List<AppGif> gif = data.map((e) => AppGif.fromJson(e)).toList();
    log(gif.length.toString());
    return gif;
  }

  getSearchResult(String search) async {
    Response response = await dio.get(
        "https://api.giphy.com/v1/gifs/search?api_key=C3K4QIt7Onh1W85eE7jFoeyHCurqOEyz&q=$search&limit=25&offset=0&rating=g&lang=en");
    List data = response.data['data'];
    List<AppGif> gif = data.map((e) => AppGif.fromJson(e)).toList();
    return gif;
  }

  getTrendingSticker() async {
    Response response = await dio.get(
        'https://api.giphy.com/v1/stickers/trending?api_key=C3K4QIt7Onh1W85eE7jFoeyHCurqOEyz&limit=50&rating=g');
    List data = response.data['data'];
    List<AppGif> stickers = data.map((e) => AppGif.fromJson(e)).toList();
    log(stickers.length.toString());
    return stickers;
  }

  getSearchResultSticker(String search) async {
    Response response = await dio.get(
        "https://api.giphy.com/v1/stickers/search?api_key=C3K4QIt7Onh1W85eE7jFoeyHCurqOEyz&q=$search&limit=50&offset=0&rating=g&lang=en");
    List data = response.data['data'];
    List<AppGif> stickers = data.map((e) => AppGif.fromJson(e)).toList();
    return stickers;
  }

  getRandomGif() async {
    Response response = await dio.get(
        "https://api.giphy.com/v1/gifs/random?api_key=C3K4QIt7Onh1W85eE7jFoeyHCurqOEyz&tag=&rating=g");

    return AppGif.fromJson(response.data['data']);
  }
}
