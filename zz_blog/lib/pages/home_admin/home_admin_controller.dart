import 'package:get/get.dart';
import 'package:zz_blog/config.dart';
import 'package:zz_blog/pages/login/login_model.dart';
import 'package:zz_blog/utils/qiniu_util.dart';

import '../../services/user.dart';
class HomeAdminController extends GetxController{
  final count = 0.obs;
  void increment() => count.value++;
  //final token = QINIU_UPLOAD_TOKEN.obs;
  UserModel userModel = UserModel();
  String qiniuToken = "";
  final picAvatar = "https://cdn.pixabay.com/photo/2020/03/31/19/20/dog-4988985_960_720.jpg".obs;

  @override
  void onInit() {
    userModel = Get.arguments;
    UserAPI.getQiniuToken().then((value) {
      qiniuToken = value;
      print(value);
    });
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}



}