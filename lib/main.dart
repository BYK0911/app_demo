import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import './routes/index.dart';
import './utils/route_util.dart';
import './i18n/index.dart';

void main() {
  runApp(const MyApp());
  // const Locale locale = Locale('en', 'US');
  // Get.updateLocale(locale);
  // print(locale);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(380, 690),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: routes,
        navigatorObservers: [RouteInterceptor()],
        locale: const Locale('en', 'US'),
        translations: Messages(),
      ),
    );
  }
}
