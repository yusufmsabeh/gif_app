import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return SizedBox(
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            height: 200.h,
            child: Column(children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Reset Password",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: TextFormField(
                            controller: provider.resetPasswordContoller,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ))),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 130.w,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: () => provider.ResetPassword(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Send email"),
                        Spacer(),
                        Icon(Icons.send_outlined)
                      ],
                    )),
              )
            ]),
          ),
        ),
      );
    });
  }
}
