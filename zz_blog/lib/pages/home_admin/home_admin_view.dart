import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zz_blog/config.dart';
import 'package:zz_blog/pages/home_admin/home_admin_controller.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeAdminPage extends GetView<HomeAdminController>{
  final sideBarController = SidebarXController(selectedIndex: 0,extended: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _siderBarx(sidebarXController: sideBarController,homeAdminController: controller,),
          Expanded(
            child: _ScreensExample(sidebarXController: sideBarController,homeAdminController: controller,)
          ),
        ],
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.sidebarXController,
    required this.homeAdminController,
  }) : super(key: key);

  final HomeAdminController homeAdminController;
  final SidebarXController sidebarXController;

  void startUpload (PlatformFile? selectedFile) {
    //String token = homeAdminController.token.value;
    Storage storage = Storage();
    PutOptions? putoptions = const PutOptions(
      key: "avatar1",
    );
    Future<PutResponse> upload = storage.putBytes(selectedFile!.bytes!, homeAdminController.qiniuToken,options: putoptions);
    upload.then((PutResponse response) {
      homeAdminController.picAvatar.value = QINIU_CDN_HOST + response.key.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sidebarXController,
      builder: (context, child) {
        switch (sidebarXController.selectedIndex) {
          case 0:
            return ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text('头像预览'),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  child: Obx(() =>CachedNetworkImage(
                    placeholder: (context,url) => const CircularProgressIndicator(),
                    imageUrl: homeAdminController.picAvatar.value,
                  )
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                         FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
                             allowMultiple: false,
                             allowedExtensions: ['jpg','png'],
                             type: FileType.custom,
                         );
                         startUpload(fileResult?.files.first);
                      },
                      child: Text('上传头像'),
                    ),
                  ),
                ),
              ],
            );
          case 1:
            return Scaffold(
              appBar: AppBar(
                title: Text(sidebarXController.selectedIndex.toString()),
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Obx(() => Center(child: Text(homeAdminController.count.toString()))),
                  TextButton(onPressed: ()=> homeAdminController.increment(), child: Text('加1')),
                ],
              ),
            );
          default:
            return Text(sidebarXController.selectedIndex.toString());
        }

      },
    );
  }
}

class _siderBarx extends StatelessWidget{
  final HomeAdminController homeAdminController;
  final SidebarXController sidebarXController;
  const _siderBarx({
    Key? key,
    required this.sidebarXController,
    required this.homeAdminController,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: sidebarXController,
      theme: const SidebarXTheme(
        margin: EdgeInsets.all(10),
      ),
      extendedTheme: const SidebarXTheme(
        width: 100,
      ),

      items: const [
        SidebarXItem(
          iconWidget: SizedBox(
              height: 60,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  foregroundImage: AssetImage('avatar1.jpg'),
                ),
              )
          ),
        ),
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
        ),
        SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        SidebarXItem(
          icon: Icons.favorite,
          label: 'Favorite',
        ),
        SidebarXItem(
          iconWidget: FlutterLogo(size: 20),
          label: 'Flutter',
        ),
      ],
    );
  }
}

