import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zz_blog/common/langs/translations.dart';
import 'package:zz_blog/pages/index/index_binding.dart';
import 'package:zz_blog/pages/index/index_view.dart';
import 'package:zz_blog/router/app_pages.dart';

import 'common/themes/theme.dart';
import 'global.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ZZ GEEK BLOG',
      home: IndexPage(),
      initialBinding: IndexBinding(),
      debugShowCheckedModeBanner: false,
      theme: Themes.white,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      enableLog: true,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: AppPages.unknownRoute,
      builder: EasyLoading.init(),
      defaultTransition: Transition.fade,
      locale: Locale('zh','Cn'),
      translationsKeys: BackTranslation.translations,
    );
  }
}

