import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:provider/provider.dart';

class SignupSigninScreen extends StatelessWidget {
  const SignupSigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<UIProvider, AuthProvider>(
          builder: (context, UIprovder, Authprovider, x) {
        return Column(
          children: [
            SizedBox(
              height: 170.h,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Text(
                          "GIF",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 50.w),
                        child: Text(
                          "CLUB",
                          style: TextStyle(color: Colors.blue, fontSize: 30.sp),
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(25.r))),
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                UIprovder.changeSigInUpPage(0);
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: UIprovder.SignInUpIndex == 0
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                UIprovder.changeSigInUpPage(1);
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: UIprovder.SignInUpIndex == 1
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r))),
                      child: UIprovder.currentWidget,
                    ),
                  ),
                ],
              ),
            ))
          ],
        );
      }),
    );
  }
}
