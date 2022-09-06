import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../router/app_routes.dart';

class NotfoundPage extends StatelessWidget {
  const NotfoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("路由没有找到"),
      ),
      body: ListTile(
        title: Text("返回首页"),
        subtitle: Text('返回首页'),
        onTap: () => Get.offAllNamed(AppRoutes.Home),
      ),
    );
  }
}