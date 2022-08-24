import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Screens/LoadingSpinner.dart';
import 'package:provider/provider.dart';

class UplaodFile extends StatelessWidget {
  const UplaodFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload GIF'),
        centerTitle: true,
      ),
      body: Consumer<FireStoreProvider>(builder: (context, provider, x) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                margin: EdgeInsets.symmetric(vertical: 15.h),
                child: Form(
                  // key: provider.addProductForm,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: provider.getImage,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 235, 235),
                                borderRadius: BorderRadius.circular(20)),
                            height: 300,
                            width: double.infinity,
                            child: provider.selectedImage == null
                                ? Icon(
                                    Icons.add,
                                    size: 40,
                                  )
                                : Image.file(
                                    provider.selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            // validator: (value) =>
                            //     provider.emptyValidation(value),
                            controller: provider.gifTitle,
                            decoration: InputDecoration(hintText: "GIF Title"),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green)),
                            onPressed: () {
                              provider.uploadGif();
                            },
                            child: Icon(Icons.upload_file_outlined)),
                      ]),
                ),
              )),
            )
          ],
        );
      }),
    );
  }
}
