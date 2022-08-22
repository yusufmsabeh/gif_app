import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Screens/CategoryScreen.dart';
import 'package:gif_app/Screens/FavoritesScreen.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<FireStoreProvider, AuthProvider, DioProvider>(
        builder: (context, FireStoreprovider, Authprovider, Dioproivder, x) {
      return Drawer(
        backgroundColor: Colors.blue,
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
                    color: Colors.blue,
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
              color: Colors.white,
            ),
            title: Text(
              'Favorites',
              style: TextStyle(
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
            leading: const Icon(
              Icons.label_important_outline,
              size: 24,
              color: Colors.white,
            ),
            title: Text(
              'Dogs',
              style: TextStyle(
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
            leading: const Icon(
              Icons.label_important_outline,
              size: 24,
              color: Colors.white,
            ),
            title: Text(
              'Cats',
              style: TextStyle(
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
            leading: const Icon(
              Icons.label_important_outline,
              size: 24,
              color: Colors.white,
            ),
            title: Text(
              'Funny',
              style: TextStyle(
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
            leading: const Icon(
              Icons.label_important_outline,
              size: 24,
              color: Colors.white,
            ),
            title: Text(
              'Meme',
              style: TextStyle(
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
            leading: const Icon(
              Icons.label_important_outline,
              size: 24,
              color: Colors.white,
            ),
            title: Text(
              'Cars',
              style: TextStyle(
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
            leading: const Icon(
              Icons.exit_to_app_rounded,
              size: 24,
              color: Colors.red,
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(
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
