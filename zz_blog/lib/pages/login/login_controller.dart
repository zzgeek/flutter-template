import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zz_blog/pages/login/login_model.dart';
import 'package:zz_blog/pages/login/myModel.dart';
import 'package:zz_blog/router/app_routes.dart';
import 'package:zz_blog/services/service.dart';
import '../../global.dart';

class LoginController extends GetxController {

  final eyeState = true.obs;

  changeEye() {
    eyeState.value = !eyeState.value;
  }

  final adminNameController = TextEditingController();
  final adminPwdController = TextEditingController();
  final userNameExp= RegExp(r"^[ZA-ZZa-z0-9_]+$");
  final regUserName = true.obs;
  final regUserPwd = true.obs;

  verifyUserName(String value) {
    if (userNameExp.hasMatch(value)  || value.length==0) {
      regUserName.value = true;
    }else {
      regUserName.value = false;
    }
  }

  verifyUserPwd(String value) {
    if (value.length < 10) {
      regUserPwd.value = true;
    }else {
      regUserPwd.value = false;
    }
  }

  mockLogin () async {
    Map<String,dynamic> param = {"id":1};
    MyModel myModel = await UserAPI.loginMock(param);
    UserModel userModel = UserModel();
    await Global.saveProfile(userModel);
    Get.toNamed(AppRoutes.Home,arguments: myModel);
  }

  mockGoLogin () async {
    UserModel userModel = await UserAPI.loginGoMock();
    print(userModel);
    await Global.saveProfile(userModel);
    Get.toNamed(AppRoutes.HomeAdmin,arguments: userModel);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

}
