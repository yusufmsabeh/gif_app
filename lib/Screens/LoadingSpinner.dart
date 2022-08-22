import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(133, 255, 255, 255),
      child: Center(
        child: SizedBox(
          child: SizedBox(
            width: 50.w,
            height: 50.h,
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
