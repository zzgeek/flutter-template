import 'package:zz_blog/pages/home_admin/home_admin_binding.dart';
import 'package:zz_blog/pages/home_admin/home_admin_view.dart';
import 'package:zz_blog/pages/siderbarx/siderbarx_view.dart';

import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import '../pages/index/index_view.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_view.dart';
import '../pages/notfound/notfound.dart';
import '../pages/proxy/proxy_view.dart';
import '../pages/sidebar/sidebar_view.dart';
import 'app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = AppRoutes.Index;

  static final routes = [
    GetPage(
      name: AppRoutes.Index,
      page: () => IndexPage(),
    ),
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.Home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.HomeAdmin,
      page: () => HomeAdminPage(),
      binding: HomeAdminBinding(),
    ),
    GetPage(
      name: AppRoutes.Proxy,
      page: () => ProxyPage(),
    ),
    GetPage(
      name: AppRoutes.Sidebar,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.SidebarX,
      page: () => SiderbarxPage(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.NotFound,
    page: () => NotfoundPage(),
  );

  static final proxyRoute = GetPage(
    name: AppRoutes.Proxy,
    page: () => ProxyPage(),
  );
}