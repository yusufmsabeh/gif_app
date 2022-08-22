import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Helpers/DioHelper.dart';
import 'package:gif_app/Model/Gif.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';

import 'package:gif_app/Providers/UIProvider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DioProvider extends ChangeNotifier {
  TextEditingController searchBarController = TextEditingController();
  DioProvider() {
    Provider.of<FireStoreProvider>(AppRouter.navKey.currentContext!).getUser();
    getTrendingGif();
    getTrendingSticker();
  }
  List<AppGif> trendingGif = [];
  List<AppGif> trendingSticker = [];
  List<AppGif> categoryList = [];
  bool isLoading = false;
  getTrendingGif([String? search]) async {
    changeLoadingState();
    if (search == null || search == '')
      trendingGif = await DioHelper.dioHelper.getTrendingGif();
    else
      trendingGif = await DioHelper.dioHelper.getSearchResult(search);

    notifyListeners();
    changeLoadingState();
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
    changeLoadingState();

    if (search == null || search == '')
      trendingSticker = await DioHelper.dioHelper.getTrendingSticker();
    else
      trendingSticker =
          await DioHelper.dioHelper.getSearchResultSticker(search);
    notifyListeners();
    changeLoadingState();
  }

  Future<List<AppGif>> getGifByIds(List ids) async {
    return await DioHelper.dioHelper.getGifByIds(ids);
  }

  getCategoryList(String search) async {
    changeLoadingState();

    categoryList = await DioHelper.dioHelper.getSearchResult(search);
    notifyListeners();
    changeLoadingState();
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

    await Share.shareFiles(text: appGif.title, [path]);
  }

  changeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
