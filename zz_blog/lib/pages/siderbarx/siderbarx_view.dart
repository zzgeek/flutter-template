import 'package:flutter/material.dart';
import 'package:zz_blog/pages/siderbarx/example_siderbax.dart';
import 'package:zz_blog/pages/siderbarx/siderbarx_controller.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class SiderbarxPage extends GetView<SiderbarxController> {
  SiderbarxPage({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0,extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    const primaryColor = Color(0xFF685BFF);
    const canvasColor = Color(0xFF2E2E48);
    const scaffoldBackgroundColor = Color(0xFF464667);
    const accentCanvasColor = Color(0xFF3E3E61);
    const white = Colors.white;
    final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
    final divider = Divider(color: white.withOpacity(0.3), height: 1);
    return Scaffold(
      key:_key,
      appBar: true ?
         AppBar(
           backgroundColor: canvasColor,
           title: Text(_getTitleByIndex(_controller.selectedIndex)),
           leading: IconButton(
             onPressed: () {
               _controller.setExtended(true);
               _key.currentState?.closeDrawer();
             },
             icon: const Icon(Icons.menu),
           ),
         )
        : null,
      drawer: ExampleSiderbax(controller: _controller,),
      body: Row(
        children: [
          ExampleSiderbax(controller: _controller),
          Expanded(
              child: Center(
                child: _ScreensExample(controller: _controller,),
              ),
          ),
        ],
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [BoxShadow()],
                ),
              ),
            );
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home 页面';
    case 1:
      return 'Search 页面';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    default:
      return 'Not found page';
  }
}