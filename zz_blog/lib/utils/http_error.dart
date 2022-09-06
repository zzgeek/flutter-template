import 'package:dio/dio.dart';
class HttpErrorEntity implements Exception{
  int? code ;
  String? message;

  HttpErrorEntity({this.code,this.message});

  String toString() {
    if (message == null) return "Exception";
    return "Exception=> code:$code ---message:$message";
  }
}

HttpErrorEntity createHttpErrorEntity (DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:{
      return HttpErrorEntity(code: -1,message: "请求取消");
    }
    case DioErrorType.connectTimeout:{
      return HttpErrorEntity(code: -1,message: "连接超时");
    }
    case DioErrorType.sendTimeout:{
      return HttpErrorEntity(code: -1,message: "请求超时");
    }
    case DioErrorType.receiveTimeout:{
      return HttpErrorEntity(code: -1,message: "响应超时");
    }
    case DioErrorType.response:{
      try {
        int? errCode = error.response?.statusCode;
        if (errCode == null) {
          return HttpErrorEntity(code: -2,message: error.message);
        }
        switch(errCode) {
          case 400:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message'] ?? "请求语法错误");
          }
          case 401:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message'] ?? "没有权限");
          }
          case 403:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message'] ?? "服务器拒绝执行");
          }
          case 404:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message'] ?? "无法连接服务器");
          }
          case 405:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message'] ?? "请求方法被禁止");
          }
          case 500:{
            return HttpErrorEntity(code:errCode,message:"服务器内部错误");
          }
          case 502:{
            return HttpErrorEntity(code:errCode,message: "无效的请求");
          }
          case 503:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message'] ?? "服务器挂了");
          }
          case 505:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message'] ?? "不支持HTTP协议请求");
          }
          default:{
            return HttpErrorEntity(code:errCode,message: error.response?.data['message']);
          }
        }
      }on Exception catch (_) {
        return HttpErrorEntity(code: -1,message: "未知错误");
      }
    }
    default:{
      return HttpErrorEntity(code: -1,message: error.message);
    }
  }
}

