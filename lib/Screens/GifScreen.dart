import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Model/Gif.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/MethodsProvider.dart';
import 'package:gif_app/Widgets/GifWidget.dart';
import 'package:provider/provider.dart';

class GifScreen extends StatelessWidget {
  var appGif;
  GifScreen({Key? key, required this.appGif}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<DioProvider, FireStoreProvider, MethodProvider>(
        builder: (context, Dioprovider, FireStoreprovider, Methodprovider, x) {
      return Scaffold(
        appBar: AppBar(
          title: Text("GIF"),
          actions: [
            IconButton(
              onPressed: () =>
                  FireStoreprovider.addOrDeleteFavorites(appGif.id),
              icon: FireStoreprovider.checkFavotites(appGif.id)
                  ? Image.asset('assets/favorite.png')
                  : Image.asset('assets/unfavorite.png'),
              // icon: Icon(
              //   Icons.favorite_border,
              //   color: FireStoreprovider.checkFavotites(appGif.id)
              //       ? Colors.red
              //       : Colors.black,
              // )
            )
          ],
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
                height: 300.h,
                child: Image.network(
                  appGif.url ?? '',
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r))),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Title:",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      width: double.infinity,
                      child: Text(
                        appGif.title ?? "",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(color: Colors.white, thickness: 2.w),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Rating:",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      width: double.infinity,
                      child: Text(
                        appGif.rating ?? "",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(color: Colors.white, thickness: 2.w),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      child: Row(children: [
                        Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      appGif.appUser!.avatarUrl ?? ''),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SizedBox(
                          child: Text(
                            appGif.appUser!.userName ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      width: 100.w,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          onPressed: () =>
                              Dioprovider.DownLoadImageAndSahre(appGif),
                          child: Row(
                            children: const [
                              Text("Share"),
                              Spacer(),
                              Icon(Icons.send_rounded),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
