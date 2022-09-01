import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Model/Gif.dart';

import 'package:gif_app/Screens/GifScreen.dart';

// ignore: must_be_immutable
class GifWidget extends StatelessWidget {
  AppGif appGif;
  GifWidget({Key? key, required this.appGif}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          AppRouter.pushWidget(GifScreen(appGif: appGif));
        },
        child: Container(
          decoration: appGif.type == 'gif'
              ? const BoxDecoration(
                  color: const Color.fromRGBO(106, 153, 78, 1),
                )
              : const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/transparent.jpg'),
                      fit: BoxFit.cover)),
          //
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: appGif.fixedUrl ?? "NO url",
            placeholder: (context, url) => SizedBox(
              height: 100.h,
              width: 100.w,
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )),
            ),
          ),
        ));
  }
}
