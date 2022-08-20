import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';
import 'package:gif_app/Screens/Homepage.dart';
import 'package:gif_app/Screens/SignupSigninScreen.dart';
import 'package:provider/provider.dart';

import 'Providers/DioProvider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<DioProvider>(create: (context) => DioProvider()),
        ChangeNotifierProvider<UIProvider>(create: (context) => UIProvider()),
        ChangeNotifierProvider(create: (context) => FireStoreProvider())
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: AppRouter.navKey,
              theme: ThemeData(primaryColorLight: Colors.red),
              home:
                  Provider.of<UIProvider>(context).HomePageController(context),
            );
          }),
    );
  }
}
