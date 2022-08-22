import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:gif_app/Screens/DrawerScreen.dart';
import 'package:gif_app/Screens/EmptyScreen.dart';
import 'package:gif_app/Widgets/GifWidget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<DioProvider, UIProvider, AuthProvider>(
        builder: (context, Dioprovider, UIprovider, Authprovider, x) {
      return Scaffold(
          drawer: DrawerScreen(),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) =>
                  UIprovider.changeBottomNavigationBarIndex(value),
              currentIndex: UIprovider.bottomNavigationBarIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.gif_box_outlined), label: "GIF"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sticky_note_2_rounded), label: "Stickers")
              ]),
          appBar: AppBar(
            title: Container(
              margin: EdgeInsets.only(top: 5.h),
              width: 267.w,
              height: 40.h,
              child: TextFormField(
                controller: Dioprovider.searchBarController,
                onFieldSubmitted: (value) => Dioprovider.SearchFunctoin(value),
                decoration: InputDecoration(
                    suffix: TextButton(
                        onPressed: () => Dioprovider.EmptyController(),
                        child: Text('X')),
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 89, 86, 233))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 201, 201, 201))),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search'),
              ),
            ),
            centerTitle: true,
          ),
          body: UIprovider.bottomNavigationBarWidget);
    });
  }
}
