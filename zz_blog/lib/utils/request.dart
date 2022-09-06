import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zz_blog/config.dart';
import 'package:zz_blog/global.dart';
import 'package:zz_blog/utils/auth.dart';

import 'http_error.dart';
class Request {
  static final Request _instance = Request._internal();
  factory Request() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  Request._internal() {
    //dio请求配置
    BaseOptions options = BaseOptions(
      //请求基地址
      baseUrl: SERVER_API_URL,
      //连接服务器超市时间
      connectTimeout: 20000,
      //响应流上前后两次接收到数据的间隔
      receiveTimeout: 5000,
      //http请求
      headers: {},
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    //cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    //添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          //请求之前做一个预处理
          return handler.next(options);
        },
        onResponse: (response,handler) {
          //返回响应数据之前做一些预处理
          return handler.next(response);
        },
        onError: (DioError e,handler){
          //请求失败时候做一些预处理
          HttpErrorEntity eInfo = createHttpErrorEntity(e);
          //错误提示
          EasyLoading.showInfo(eInfo.message.toString());
          //错误交互处理
          switch (eInfo.code) {
            case 401: {
              deleteTokenAndReLogin();
              break;
            }
          }
          return handler.next(e);
        }
     ));
  }

  //读取token
  Map<String,dynamic> getAuthorizationHeader() {
    var headers;
    String? token = Global.profile?.userToken;
    if (token != null) {
      headers = {
        'userToken' : token,
      };
    }
    return headers;
  }

  // restful get 操作
  Future get(String path,{dynamic params,Options? options}) async {
    Options requestOptions = options ?? Options();
    Map<String,dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null){
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.get(path,queryParameters: params,options: requestOptions,cancelToken: cancelToken);
    return response.data;
  }

  // restful post 操作
  Future post(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(path, data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  // restful put 操作
  Future put(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.put(path, data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  // restful patch 操作
  Future patch(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }

    var response = await dio.patch(path, data: params, options: requestOptions, cancelToken: cancelToken);

    return response.data;
  }

  // restful delete 操作
  Future delete(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.delete(path, data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  // restful post form 表单提交操作
  Future postForm(String path, {dynamic params, Options? options}) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response =
    await dio.post(path, data: FormData.fromMap(params), options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

}