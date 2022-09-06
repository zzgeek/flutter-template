import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:zz_blog/common/value/storage.dart';
import 'package:zz_blog/pages/login/login_model.dart';
import 'package:zz_blog/utils/local_storage.dart';
import 'package:zz_blog/utils/request.dart';

//全局配置
class Global {
  //用户配置 初始化token为null
  static UserModel? profile = UserModel(userToken:null);
  //是否第一次打开
  static bool isFirstOpen = false;
  //是否离线登录
  static bool isOffLineLogin = false;
  //是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //init
  static Future init() async {
    //运行初始化
    WidgetsFlutterBinding.ensureInitialized();
    //request 模块初始
    Request();
    //本地存储初始化
    await LocalStorage.init();
    //读取设备第一次打开
    isFirstOpen = !LocalStorage().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      LocalStorage().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }
    //读取离线用户信息
    var _profileJson = LocalStorage().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJson != null) {
      profile = UserModel.fromJson(_profileJson);
    }
    //android 状态栏为透明的沉浸
    // if (Platform.isAndroid){
    //   SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // }
  }

  //持久化 用户信息
  static Future<bool> saveProfile (UserModel userModel) {
    profile = userModel;
    return LocalStorage().setJson(STORAGE_USER_PROFILE_KEY, userModel.toJson());
  }


}