import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/MethodsProvider.dart';
import 'package:gif_app/Screens/LoadingSpinner.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class GifScreen extends StatelessWidget {
  var appGif;
  GifScreen({Key? key, required this.appGif}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<DioProvider, FireStoreProvider, MethodProvider>(
        builder: (context, Dioprovider, FireStoreprovider, Methodprovider, x) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("GIF".tr()),
          actions: [
            appGif.isMyGif
                ? IconButton(
                    onPressed: () => FireStoreprovider.deleteGif(appGif.id),
                    icon: Image.asset(
                      'assets/delete.png',
                      width: 25.w,
                      height: 25.h,
                    ))
                : IconButton(
                    onPressed: () =>
                        FireStoreprovider.addOrDeleteFavorites(appGif.id),
                    icon: FireStoreprovider.checkFavotites(appGif.id)
                        ? Image.asset('assets/favorite.png')
                        : Image.asset('assets/unfavorite.png'),
                  )
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Column(children: [
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 300.h,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: appGif.originalUrl,
                    placeholder: (context, url) => Container(
                        color: Colors.grey.withOpacity(.5),
                        child: Center(child: LoadingSpinner())),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  // child: Image.network(
                  //   appGif.originalUrl ?? '',
                  //   fit: BoxFit.fill,
                  // )
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 106, 153, 78),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Title".tr() + ":",
                              style: TextStyle(
                                  color: Colors.white,
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
                                  color: const Color.fromARGB(255, 56, 102, 65),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Divider(color: Colors.white, thickness: 0.5.w),
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
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 242, 232, 207),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ]),
                          ),
                          Divider(color: Colors.white, thickness: 0.5.w),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 188, 71, 73))),
                                    onPressed: () =>
                                        Dioprovider.DownLoadImageAndSahre(
                                            appGif),
                                    child: Row(
                                      children: [
                                        Text("Share".tr()),
                                        const Spacer(),
                                        const Icon(Icons.send_rounded),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 50.w,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 188, 71, 73))),
                                    onPressed: () => Methodprovider.copyText(
                                        appGif.originalUrl),
                                    child: Icon(Icons.copy)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            FireStoreprovider.isLoading
                ? const Center(
                    child: LoadingSpinner(),
                  )
                : const SizedBox()
          ],
        ),
      );
    });
  }
}
