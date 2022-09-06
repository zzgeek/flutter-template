import 'package:zz_blog/pages/login/login_model.dart';
import 'package:zz_blog/pages/login/myModel.dart';
import 'package:zz_blog/services/reponse.dart';

import '../utils/request.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserModel> login({
    required Map params,
  }) async {
    var response = await Request().post(
      '/login/',
      params: params,
    );
    return UserModel.fromJson(response['data']);
  }
  
  //mock 登录
  static Future<MyModel> loginMock (Map params) async {
    var response = await Request().get(
      '/posts/',
      params: params,
    );
    return MyModel.fromJson(response[0]);
  }

  //mock go服务端 登录
 static Future<UserModel> loginGoMock () async {
    var response = await Request().get(
      '/getUser'
    );
    print(response);
    ResponseModel responseModel = ResponseModel.fromJson(response);
    print(responseModel);
    return UserModel.fromJson(responseModel.respData);
 }

 static Future<String> getQiniuToken () async {
    var response = await Request().get(
      '/getQiniuToken'
    );
    print(response);
    ResponseModel responseModel = ResponseModel.fromJson(response);
    print(responseModel);
    return responseModel.respData;
 }
  
}