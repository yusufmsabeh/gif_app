import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Model/Gif.dart';

import 'package:gif_app/Screens/GifScreen.dart';
import 'package:gif_app/Screens/LoadingSpinner.dart';

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
          decoration: const BoxDecoration(
            color: Color.fromRGBO(106, 153, 78, 1),
            // image: DecorationImage(
            //     image: NetworkImage(
            //       appGif.fixedUrl ?? 'no url',
            //     ),
            //     fit: BoxFit.cover)
          ),
          child: CachedNetworkImage(
            imageUrl: appGif.fixedUrl ?? "NO url",
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          ),
          // child: Image.network(
          //   appGif.fixedUrl ?? 'no url',
          //   fit: BoxFit.cover,
          // ),
        ));
  }
}
