import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            title: Text(Title),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                child: provider.categoryList.isEmpty
                    ? const EmptyScreen()
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.h,
                            crossAxisSpacing: 14.w,
                            mainAxisSpacing: 14.h),
                        itemCount: provider.categoryList.length,
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
