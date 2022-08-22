import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/MethodsProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, MethodProvider>(
        builder: (context, Authprovider, Methodprovider, x) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0.w),
          child: Form(
              key: Authprovider.signUpKey,
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Welcome back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.sp),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  const SizedBox(
                      width: double.infinity, child: Text("Create account ")),
                  SizedBox(
                    height: 30.h,
                  ),
                  const SizedBox(width: double.infinity, child: Text("Email")),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Methodprovider.emailValidate(value),
                    controller: Authprovider.emailSignUpController,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const SizedBox(
                      width: double.infinity, child: Text("Username")),
                  TextFormField(
                    validator: (value) =>
                        Methodprovider.userNameValidate(value),
                    controller: Authprovider.userNameSignUpController,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const SizedBox(
                      width: double.infinity, child: Text("Password")),
                  TextFormField(
                    validator: (value) =>
                        Methodprovider.passwordValidate(value),
                    obscureText: true,
                    controller: Authprovider.passwordSignUpController,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () => Authprovider.SignUp(),
                    child: Container(
                        width: 314.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
