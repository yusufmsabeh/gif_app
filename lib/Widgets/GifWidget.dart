import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Model/Gif.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Screens/GifScreen.dart';
import 'package:provider/provider.dart';

class GifWidget extends StatelessWidget {
  AppGif appGif;
  GifWidget({Key? key, required this.appGif}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          await Provider.of<DioProvider>(context, listen: false).getRandomGif();
          AppRouter.pushWidget(GifScreen(appGif: appGif));
        },
        child: Image.network(appGif.url ?? 'no url'));
  }
}
