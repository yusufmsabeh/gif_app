import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:gif_app/Screens/EmptyScreen.dart';
import 'package:gif_app/Screens/LoadingSpinner.dart';
import 'package:gif_app/Widgets/GifWidget.dart';
import 'package:provider/provider.dart';

class MyGifsScreen extends StatelessWidget {
  const MyGifsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<DioProvider, UIProvider, AuthProvider>(
        builder: (context, Dioprovider, UIprovider, Authprovider, x) {
      return Scaffold(
          appBar: AppBar(
            title: Text("MyGif".tr()),
            centerTitle: true,
          ),
          body: Consumer<FireStoreProvider>(
              builder: (context, FireStoreprovider, x) {
            return Stack(
              children: [
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                    child: FireStoreprovider.MyGif.isEmpty
                        ? const EmptyScreen()
                        : MasonryGridView.count(
                            itemCount: FireStoreprovider.MyGif.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemBuilder: (context, index) => GifWidget(
                                appGif: FireStoreprovider.MyGif[index]))),
                FireStoreprovider.isLoading
                    ? const Center(
                        child: LoadingSpinner(),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      )
              ],
            );
          }));
    });
  }
}
