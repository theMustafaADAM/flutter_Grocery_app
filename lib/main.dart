import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_ecommerce_app/model/ad_banner.dart';
import 'package:flutter_ecommerce_app/model/category.dart';
import 'package:flutter_ecommerce_app/model/product.dart';
import 'package:flutter_ecommerce_app/route/app_page.dart';
import 'package:flutter_ecommerce_app/route/app_route.dart';
import 'package:flutter_ecommerce_app/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // register adapters
  Hive.registerAdapter(AdBannerAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(UserAdapter());

  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPage.list,
      initialRoute: AppRoute.dashboard,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
    );

  }
}

void configLoading() {
  EasyLoading.instance
  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
  ..userInteractions = EasyLoadingMaskType.black as bool?
  ..displayDuration = const Duration(milliseconds: 2000)
  ..loadingStyle = EasyLoadingStyle.dark
  ..backgroundColor = Colors.green
  ..indicatorColor = Colors.white
  ..progressColor = Colors.white
  ..textColor = Colors.white
  ..indicatorSize = 45.0
  ..dismissOnTap = true 
  ..radius = 10.0;
}
