import 'package:get/get.dart';
import 'package:zz_blog/pages/login/login_model.dart';
import 'package:zz_blog/pages/login/myModel.dart';

import '../../common/value/storage.dart';
import '../../utils/local_storage.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  String userName = 'burnish';
  MyModel myModel = MyModel();
  UserModel userModel = UserModel();

  @override
  void onInit() {
    // TODO: implement onInit
    myModel = Get.arguments;
    userModel = UserModel.fromJson(LocalStorage().getJSON(STORAGE_USER_PROFILE_KEY));
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;

  void changeUserName() {
    userName = 'juefei';
    update();
  }

  final selected = "中文".obs;
  String cn = "中文";
  String en = "英文";

  void setSelected(String value) {
    selected.value = value;
  }



}
