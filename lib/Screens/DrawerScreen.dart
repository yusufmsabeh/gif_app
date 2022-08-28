import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Screens/CategoryScreen.dart';
import 'package:gif_app/Screens/FavoritesScreen.dart';
import 'package:gif_app/Screens/MyGifsScreen.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<FireStoreProvider, AuthProvider, DioProvider>(
        builder: (context, FireStoreprovider, Authprovider, Dioproivder, x) {
      return Drawer(
        width: 210.w,
        backgroundColor: const Color.fromARGB(255, 56, 102, 65),
        child: ListView(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 70.w,
              height: 30.h,
              margin: EdgeInsets.only(top: 30.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Text(
                "GIF",
                style: TextStyle(
                    color: const Color.fromARGB(255, 106, 153, 78),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 70.w, left: 10.w),
              child: Text(
                "CLUB",
                style: TextStyle(color: Colors.white, fontSize: 30.sp),
              ),
            )
          ]),
          const Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              FireStoreprovider.fillFavoritesGif();
              AppRouter.pushWidget(const FavoritesScreen());
            },
            leading: const Icon(
              Icons.favorite,
              size: 24,
              color: Color.fromARGB(255, 188, 71, 73),
            ),
            title: Text(
              'Favorites'.tr(),
              style: TextStyle(
                  color: const Color.fromARGB(255, 242, 232, 207),
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
          ListTile(
            onTap: () {
              FireStoreprovider.getMyGifs();
              AppRouter.pushWidget(const MyGifsScreen());
            },
            leading: Image.asset(
              "assets/gif.png",
              width: 25.w,
              height: 25.h,
            ),
            title: Text(
              'MyGif'.tr(),
              style: TextStyle(
                  color: const Color.fromARGB(255, 242, 232, 207),
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              Dioproivder.getCategoryList('Dogs');
              AppRouter.pushWidget(CategoryScreen(Title: 'Dogs'));
            },
            leading: Image.asset(
              "assets/label.png",
              width: 25.w,
              height: 25.h,
            ),
            title: Text(
              'Dogs'.tr(),
              style: TextStyle(
                  color: const Color.fromARGB(255, 242, 232, 207),
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
          ListTile(
            onTap: () {
              Dioproivder.getCategoryList('Cats');
              AppRouter.pushWidget(CategoryScreen(Title: 'Cats'));
            },
            leading: Image.asset(
              "assets/label.png",
              width: 25.w,
              height: 25.h,
            ),
            title: Text(
              'Cats'.tr(),
              style: TextStyle(
                  color: const Color.fromARGB(255, 242, 232, 207),
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
          ListTile(
            onTap: () {
              Dioproivder.getCategoryList('Funny');
              AppRouter.pushWidget(CategoryScreen(Title: 'Funny'));
            },
            leading: Image.asset(
              "assets/label.png",
              width: 25.w,
              height: 25.h,
            ),
            title: Text(
              'Funny'.tr(),
              style: TextStyle(
                  color: const Color.fromARGB(255, 242, 232, 207),
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
          ListTile(
            onTap: () {
              Dioproivder.getCategoryList('Meme');
              AppRouter.pushWidget(CategoryScreen(Title: 'Meme'));
            },
            leading: Image.asset(
              "assets/label.png",
              width: 25.w,
              height: 25.h,
            ),
            title: Text(
              'Meme'.tr(),
              style: TextStyle(
                  color: const Color.fromARGB(255, 242, 232, 207),
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
          ListTile(
            onTap: () {
              Dioproivder.getCategoryList('Cars');
              AppRouter.pushWidget(CategoryScreen(Title: 'Cars'));
            },
            leading: Image.asset(
              "assets/label.png",
              width: 25.w,
              height: 25.h,
            ),
            title: Text(
              'Cars'.tr(),
              style: TextStyle(
                  color: const Color.fromARGB(255, 242, 232, 207),
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: () => Authprovider.SignOut(),
            leading: Image.asset(
              "assets/signout.png",
              width: 25.w,
              height: 25.h,
            ),
            title: Text(
              'SignOut'.tr(),
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
        ]),
      );
    });
  }
}
