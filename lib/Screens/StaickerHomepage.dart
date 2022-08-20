import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:provider/provider.dart';

import '../Widgets/GifWidget.dart';
import 'EmptyScreen.dart';

class StickerHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DioProvider>(builder: (context, Dioprovider, x) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
        child: Dioprovider.trendingSticker.isEmpty
            ? const EmptyScreen()
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.h,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 14.h),
                itemCount: Dioprovider.trendingSticker.length,
                itemBuilder: (context, index) =>
                    GifWidget(appGif: Dioprovider.trendingSticker[index])),
      );
    });
  }
}
