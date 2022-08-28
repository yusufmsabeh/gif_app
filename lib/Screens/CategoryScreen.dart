import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Screens/EmptyScreen.dart';
import 'package:gif_app/Screens/LoadingSpinner.dart';
import 'package:gif_app/Widgets/GifWidget.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  String Title;
  CategoryScreen({Key? key, required this.Title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Scaffold(
          appBar: AppBar(
            title: Text(Title.tr()),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                child: provider.categoryList.isEmpty
                    ? const EmptyScreen()
                    : MasonryGridView.count(
                        itemCount: provider.categoryList.length,
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemBuilder: (context, index) =>
                            GifWidget(appGif: provider.categoryList[index])),
              ),
              provider.isLoading
                  ? const Center(
                      child: LoadingSpinner(),
                    )
                  : const SizedBox()
            ],
          ));
    });
  }
}
