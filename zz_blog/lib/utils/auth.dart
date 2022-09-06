import 'package:zz_blog/utils/local_storage.dart';
import 'package:get/get.dart';
import '../common/value/storage.dart';
import '../global.dart';
//检查是否存在 token
Future<bool> isAuth() async {
  var profileJSON = LocalStorage().getJSON(STORAGE_USER_PROFILE_KEY);
  return profileJSON != null ? true : false;
}

//删除缓存token
Future delAuthToken() async {
  await LocalStorage().remove(STORAGE_USER_PROFILE_KEY);
  Global.profile = null;
}

/// 重新登录
void deleteTokenAndReLogin() async {
  await delAuthToken();
  Get.offAndToNamed('/login');
}