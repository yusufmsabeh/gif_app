import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Helpers/DioHelper.dart';
import 'package:gif_app/Model/Gif.dart';

import 'package:gif_app/Providers/UIProvider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DioProvider extends ChangeNotifier {
  TextEditingController searchBarController = TextEditingController();
  DioProvider() {
    getTrendingGif();
    getTrendingSticker();
  }
  List<AppGif> trendingGif = [];
  List<AppGif> trendingSticker = [];

  AppGif? randomGif;

  getTrendingGif([String? search]) async {
    if (search == null || search == '')
      trendingGif = await DioHelper.dioHelper.getTrendingGif();
    else
      trendingGif = await DioHelper.dioHelper.getSearchResult(search);
    notifyListeners();
  }

  getRandomGif() async {
    randomGif = await DioHelper.dioHelper.getRandomGif();
    notifyListeners();
  }

  SearchFunctoin(String value) {
    if (Provider.of<UIProvider>(AppRouter.navKey.currentContext!, listen: false)
            .bottomNavigationBarIndex ==
        0)
      getTrendingGif(value);
    else
      getTrendingSticker(value);
  }

  getTrendingSticker([String? search]) async {
    if (search == null || search == '')
      trendingSticker = await DioHelper.dioHelper.getTrendingSticker();
    else
      trendingSticker =
          await DioHelper.dioHelper.getSearchResultSticker(search);
    notifyListeners();
  }

  share() async {
    await FlutterShare.share(
        title: 'Share',
        text: 'Example share text',
        linkUrl: "random",
        chooserTitle: 'Example Chooser Title');
  }

  EmptyController() {
    searchBarController.text = '';
    getTrendingGif();
  }

  DownLoadImageAndSahre(AppGif appGif) async {
    final uri = Uri.parse(appGif.url ?? '');
    final response = await http.get(uri);
    final bytes = response.bodyBytes;

    final temp = await getTemporaryDirectory();
    final String path = '${temp.path}/${appGif.title}.gif';
    File(path).writeAsBytesSync(bytes);
    log(path);
    await Share.shareFiles(text: appGif.title, [path]);
  }
}
