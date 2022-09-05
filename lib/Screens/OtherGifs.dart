import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../Providers/AuthProvider.dart';
import '../Providers/DioProvider.dart';
import '../Providers/FireStoreProvider.dart';
import '../Providers/UIProvider.dart';
import '../Widgets/GifWidget.dart';
import 'EmptyScreen.dart';
import 'LoadingSpinner.dart';

class OtherGifs extends StatelessWidget {
  const OtherGifs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<DioProvider, UIProvider, AuthProvider>(
        builder: (context, Dioprovider, UIprovider, Authprovider, x) {
      return Scaffold(
          appBar: AppBar(
            title: Text("OtherGif".tr()),
            centerTitle: true,
          ),
          body: Consumer<FireStoreProvider>(
              builder: (context, FireStoreprovider, x) {
            return Stack(
              children: [
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                    child: FireStoreprovider.otherGif.isEmpty
                        ? const EmptyScreen()
                        : MasonryGridView.count(
                            itemCount: FireStoreprovider.otherGif.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemBuilder: (context, index) => GifWidget(
                                appGif: FireStoreprovider.otherGif[index]))),
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
