import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, Authprovider, x) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0.w),
          child: Form(
              child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Welcome back",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                  )),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text("Sign in with your account")),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(width: double.infinity, child: Text("Email")),
              TextFormField(),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(width: double.infinity, child: Text("Password")),
              TextFormField(),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () => Authprovider.SignIn(),
                child: Container(
                    width: 314.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Forgot your password?'),
                TextButton(onPressed: () => null, child: Text("Reset here"))
              ])
            ],
          )),
        ),
      );
    });
  }
}
