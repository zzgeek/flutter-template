import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global.dart';
import '../home/home_view.dart';
import '../login/login_view.dart';
import 'index_controller.dart';
import '../splash/splash_view.dart';
class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Obx(() => Scaffold(
      body: controller.isLoadWelcomePage.isTrue ? SplashPage() : Global.isOffLineLogin ? HomePage() : LoginPage(),
    ));
  }
}