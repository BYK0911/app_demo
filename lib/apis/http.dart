/// 封装网络请求
///
/// 统一设置请求选项，统一错误处理
///
/// 用法示例:
/// import '../apis/http.dart'
///
/// Future<dynamic> function login (String username, String password) {
///   return Http().dio.post(
///     '/login',
///     data: {
///       'username': username,
///       'password': password
///     }
///   )
/// }
///

import 'package:dio/dio.dart';

class Http {
  factory Http() => _getInstance();

  static Http? _instance;
  late Dio dio;

  static Http _getInstance() {
    _instance ??= Http._();
    return _instance!;
  }

  Http._() {
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: 10000,
        receiveTimeout: 300000,
        responseType: ResponseType.json,
        headers: {
          "Content-Type": "application/json",
        },
      ),
    )
      ..interceptors.add(RequestInterceptor())
      ..interceptors.add(ResponseInterceptor());
  }
}

class RequestInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions requestOptions,
    RequestInterceptorHandler handler,
  ) {
    // 请求拦截
    handler.next(requestOptions);
  }
}

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 响应拦截
    // 统一错误处理
    if (response.data['code'] == '000001') {
      // 跳转至登陆页
    } else if (response.data['code'] != 'SUC') {
      // 提示错误信息
    } else {
      // if (response.headers['responseType'] == 'blob') {
      //   // 下载文件
      // } else {
      //   handler.next(response);
      // }
      handler.next(response);
    }
  }
}
