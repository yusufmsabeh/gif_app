import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:provider/provider.dart';

import '../Widgets/GifWidget.dart';
import 'EmptyScreen.dart';
import 'LoadingSpinner.dart';

class GifHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer2<DioProvider, AuthProvider>(
        builder: (context, Dioprovider, Authprovider, x) {
      return Stack(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
              child: Dioprovider.trendingGif.isEmpty
                  ? const EmptyScreen()
                  : MasonryGridView.count(
                      itemCount: Dioprovider.trendingGif.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) =>
                          GifWidget(appGif: Dioprovider.trendingGif[index]))
              // : GridView.builder(
              //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //         maxCrossAxisExtent: 200.h,
              //         crossAxisSpacing: 14.w,
              //         mainAxisSpacing: 14.h),
              //     itemCount: Dioprovider.trendingGif.length,
              //     itemBuilder: (context, index) =>
              //         GifWidget(appGif: Dioprovider.trendingGif[index])),
              ),
          Dioprovider.isLoading
              ? const Center(child: LoadingSpinner())
              : const SizedBox()
        ],
      );
    });
  }
}
