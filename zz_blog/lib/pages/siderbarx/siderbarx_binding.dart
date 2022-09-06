import 'package:get/get.dart';
import 'package:zz_blog/pages/siderbarx/siderbarx_controller.dart';

class SiderbarxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiderbarxController>(() => SiderbarxController());
  }
}