import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';
import 'package:gif_app/Providers/AuthProvider.dart';
import 'package:gif_app/Providers/FireStoreProvider.dart';
import 'package:gif_app/Providers/MethodsProvider.dart';
import 'package:gif_app/Providers/UIProvider.dart';

import 'package:provider/provider.dart';

import 'Providers/DioProvider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = const {
      50: Color.fromRGBO(167, 201, 87, .1),
      100: Color.fromRGBO(167, 201, 87, .2),
      200: Color.fromRGBO(167, 201, 87, .3),
      300: Color.fromRGBO(167, 201, 87, .4),
      400: Color.fromRGBO(167, 201, 87, .5),
      500: Color.fromRGBO(167, 201, 87, .6),
      600: Color.fromRGBO(167, 201, 87, .7),
      700: Color.fromRGBO(167, 201, 87, .8),
      800: Color.fromRGBO(167, 201, 87, .9),
      900: Color.fromRGBO(167, 201, 87, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF6A994E, color);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => FireStoreProvider()),
        ChangeNotifierProvider<DioProvider>(create: (context) => DioProvider()),
        ChangeNotifierProvider<UIProvider>(create: (context) => UIProvider()),
        Provider(create: (context) => MethodProvider())
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/lans',
        fallbackLocale: const Locale('en'),
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                navigatorKey: AppRouter.navKey,
                theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSwatch(primarySwatch: colorCustom)),
                home: Provider.of<UIProvider>(context)
                    .HomePageController(context),
              );
            }),
      ),
    );
  }
}
