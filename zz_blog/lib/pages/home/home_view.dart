
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zz_blog/pages/home/widgets/console.dart';
import 'package:zz_blog/pages/home/widgets/select_file.dart';
import 'package:zz_blog/router/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';
import 'package:file_picker/file_picker.dart';

import 'widgets/token.dart';
import 'widgets/uint.dart';
import 'widgets/string_input.dart';
import 'home_controller.dart';
import 'widgets/progress.dart' as homeProgress;

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final storage = Storage();

  // 用户输入的文件名
  String? Namekey;

  // 用户输入的 partSize
  int partSize = 4;

  // 用户输入的 token
  String? token;

  /// 当前选择的文件
  PlatformFile? selectedFile;

  // 当前的进度
  double progressValue = 1;

  // 当前的任务状态
  StorageStatus? statusValue;

  // 控制器，可以用于取消任务、获取上述的状态，进度等信息
  PutController? putController;

  void onStatus(StorageStatus status) {
    print('状态变化: 当前任务状态：${status.toString()}');
    statusValue = status;
  }

  void onProgress(double percent) {
     progressValue = percent;
    print('任务进度变化：进度：${percent.toStringAsFixed(4)}');
  }

  void onSendProgress(double percent) {
    // setState(() => progressValue = percent);
    print('实际发送变化：进度：${percent.toStringAsFixed(4)}');
  }

  void startUpload() {
    print('创建 PutController');
    putController = PutController();

    print('添加实际发送进度订阅');
    putController!.addSendProgressListener(onSendProgress);

    print('添加任务进度订阅');
    putController!.addProgressListener(onProgress);

    print('添加状态订阅');
    putController!.addStatusListener(onStatus);

    var usedToken = token;

    if (token == null || token == '') {
      if (builtinToken != null && builtinToken != '') {
        print('使用内建 Token 进行上传');
        usedToken = builtinToken;
      }
    }

    if (usedToken == null || usedToken == '') {
      print('token 不能为空');
      return;
    }

    if (selectedFile == null) {
      print('请选择文件');
      return;
    }

    print('开始上传文件');

    final putOptions = PutOptions(
      key: Namekey,
      partSize: partSize,
      controller: putController,
    );
    Future<PutResponse> upload;
    if (kIsWeb) {
      upload = storage.putBytes(
        selectedFile!.bytes!,
        usedToken,
        options: putOptions,
      );
    } else {
      upload = storage.putFile(
        File(selectedFile!.path!),
        usedToken,
        options: putOptions,
      );
    }

    upload
      ..then((PutResponse response) {
        print('上传已完成: 原始响应数据: ${jsonEncode(response.rawData)}');
        print('------------------------');
      })
      ..catchError((dynamic error) {
        if (error is StorageError) {
          switch (error.type) {
            case StorageErrorType.CONNECT_TIMEOUT:
              print('发生错误: 连接超时');
              break;
            case StorageErrorType.SEND_TIMEOUT:
              print('发生错误: 发送数据超时');
              break;
            case StorageErrorType.RECEIVE_TIMEOUT:
              print('发生错误: 响应数据超时');
              break;
            case StorageErrorType.RESPONSE:
              print('发生错误: ${error.message}');
              break;
            case StorageErrorType.CANCEL:
              print('发生错误: 请求取消');
              break;
            case StorageErrorType.UNKNOWN:
              print('发生错误: 未知错误');
              break;
            case StorageErrorType.NO_AVAILABLE_HOST:
              print('发生错误: 无可用 Host');
              break;
            case StorageErrorType.IN_PROGRESS:
              print('发生错误: 已在队列中');
              break;
          }
        } else {
          print('发生错误: ${error.toString()}');
        }

        print('------------------------');
      });
  }

  void onKeyChange(String key) {
    if (key == '') {
      print('清除 key');
      this.Namekey = null;
      return;
    }
    print('设置 key: $key');
    this.Namekey = key;
  }

  void onPartSizeChange(String partSize) {
    if (partSize == '') {
      print('设置默认 partSize');
      this.partSize = 4;
      return;
    }
    print('设置 partSize: $partSize');
    this.partSize = int.parse(partSize);
  }

  void onTokenChange(String token) {
    if (token == '') {
      print('清除 token');
      this.token = null;
      return;
    }
    print('设置 Token: $token');
    this.token = token;
  }

  void onSelectedFile(PlatformFile file) {
    print('选中文件: ${file.path}');
    // ignore: unnecessary_null_comparison
    if (file.size != null) {
      // 一般在非 web 平台上可以直接读取 size 属性
      print('文件尺寸：${humanizeFileSize(file.size.toDouble())}');
    } else if (file.bytes != null) {
      print('文件尺寸：${humanizeFileSize(file.bytes!.length.toDouble())}');
    }

    print('设置 selectedFile');
    selectedFile = file;
    startUpload();
  }

  Widget get cancelButton {
    if (statusValue == StorageStatus.Request) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
          child: Text('取消上传'),
          onPressed: () => putController?.cancel(),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          textColor: Colors.white,
          color: Colors.red,
        ),
      );
    }
    return SizedBox.shrink();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('frontPage'.tr),
      ),
       body:Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Center(child: Text(controller.count.toString()))),
              TextButton(onPressed: ()=> controller.increment(), child: Text('加1')),
              GetBuilder<HomeController>(builder: (_) {
                return Text(controller.userName);
              }),
              TextButton(onPressed: ()=> controller.changeUserName(), child: Text('改名')),
              TextButton(onPressed: ()=> Get.toNamed(AppRoutes.Proxy), child: Text('进入代理页面')),
              Obx(() => DropdownButton<String>(
                  hint: Text('下拉框'),
                  items: [
                    DropdownMenuItem(child: Text(controller.cn.toString()),value: controller.cn,),
                    DropdownMenuItem(child: Text(controller.en.toString()),value: controller.en,),
                  ],
                  value: controller.selected.value,
                  onChanged: (newvalue) {
                    controller.selected(newvalue.toString());
                  }
              )
              ),
              Row(
                children: [
                  Text('mymodeltitle:' + controller.myModel.title.toString()),
                ],
              ),
              TextButton(
                onPressed: () => EasyLoading.showInfo('自定义提示'),
                child: Text('提示'),
              ),
              TextButton(
                onPressed: () => Get.snackbar('snackbarTitle','message'),
                child: Text('getsnackbar'),
              ),
              TextButton(
                onPressed: () => Get.defaultDialog(onConfirm: ()=> print('好的'),middleText: 'middleText',onCancel: ()=> print('取消')),
                child: Text('defaultDialog'),
              ),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.Sidebar),
                child: Text('sidebar'),
              ),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.SidebarX),
                child: const Text('siderbarX'),
              ),
              Padding(
              padding: EdgeInsets.all(20),
              child: homeProgress.Progress(progressValue),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StringInput(
                  onKeyChange,
                  label: '请输入 Key（可选）回车确认',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StringInput(
                  onPartSizeChange,
                  label: '请输入分片尺寸，单位 M（默认 4，可选）回车确认',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StringInput(
                  onTokenChange,
                  label: '请输入 Token（可选）回车确认',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectFile(onSelectedFile),
              ),
              cancelButton,
              Padding(
                key: Key('console'),
                child: const Console(),
                padding: EdgeInsets.all(8.0),
              ),
            ],
          ),
        ),
    );
  }
}
