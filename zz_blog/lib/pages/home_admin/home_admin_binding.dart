import 'package:get/get.dart';
import 'package:zz_blog/pages/home_admin/home_admin_controller.dart';
class HomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeAdminController>(() => HomeAdminController());
  }

}