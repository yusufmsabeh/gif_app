import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/DioProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:gif_app/Screens/DrawerScreen.dart';
import 'package:gif_app/Screens/LoadingSpinner.dart';
import 'package:gif_app/Screens/UploadFile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer4<DioProvider, UIProvider, AuthProvider, FireStoreProvider>(
        builder: (context, Dioprovider, UIprovider, Authprovider,
            FireStoreprovider, x) {
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: GestureDetector(
            onTap: (() async {
              await FireStoreprovider.getUserGif();
              AppRouter.pushWidget(const UplaodFile());
            }),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              // margin: context.locale.toString() == 'ar'
              //     ? EdgeInsets.only(left: 100.w)
              //     : EdgeInsets.only(right: 102.w),
              height: 35.h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r)),
              child: SizedBox(
                width: 95.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/fileupload.png',
                      width: 25.w,
                      height: 25.h,
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        "Upload".tr(),
                        style: const TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: const DrawerScreen(),
          bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 0,
              onTap: (value) =>
                  UIprovider.changeBottomNavigationBarIndex(value),
              currentIndex: UIprovider.bottomNavigationBarIndex,
              items: [
                BottomNavigationBarItem(
                    activeIcon: Image.asset(
                      'assets/selectedgif.png',
                      width: 30.w,
                      height: 30.h,
                    ),
                    icon: Image.asset(
                      'assets/unselectedgif.png',
                      width: 30.w,
                      height: 30.h,
                    ),
                    label: "GIF"),
                BottomNavigationBarItem(
                    activeIcon: Image.asset(
                      'assets/selectedstickers.png',
                      width: 30.w,
                      height: 30.h,
                    ),
                    icon: Image.asset(
                      'assets/unselectedstickers.png',
                      width: 30.w,
                      height: 30.h,
                    ),
                    label: "Stickers")
              ]),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    context.locale.toString() == 'ar'
                        ? context.setLocale(const Locale('en'))
                        : context.setLocale(const Locale('ar'));
                  },
                  icon: Icon(Icons.language))
            ],
            title: Container(
              margin: EdgeInsets.only(top: 5.h),
              // width: 267.w,
              height: 40.h,
              child: TextFormField(
                controller: Dioprovider.searchBarController,
                onFieldSubmitted: (value) => Dioprovider.SearchFunctoin(value),
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                    isDense: true,
                    suffix: Container(
                      width: 20.w,
                      height: 20.h,
                      margin: EdgeInsets.only(top: 15.h),
                      child: InkWell(
                          onTap: () {
                            Dioprovider.EmptyController();
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          child: const Text(
                            'X',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 188, 71, 73))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 201, 201, 201))),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search'.tr()),
              ),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              UIprovider.bottomNavigationBarWidget,
              Dioprovider.isLoading
                  ? const Center(
                      child: LoadingSpinner(),
                    )
                  : const SizedBox()
            ],
          ));
    });
  }
}
