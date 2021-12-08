/// 封装网络请求
///
/// 用法示例:
/// import 'package:mars_app/lib/apis/http.dart'
///
/// Future<Response> function login (String username, String password) {
///   return dio.post(
///     '/login',
///     data: {
///       'username': username,
///       'password': password
///     }
///   )
/// }
///

import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mars_app/utils/toast_util.dart';

Dio dio = Dio()
  ..options = BaseOptions(
    baseUrl: 'http://localhost:8080', // 请求根路径
    connectTimeout: 10000, // 连接超时时间，10秒
    receiveTimeout: 300000, // 接收超时时间，5分钟
    responseType: ResponseType.json, // 响应数据格式，json格式
    headers: {
      "Content-Type": "application/json", // 请求数据格式
    },
  )
  ..interceptors.add(_Interceptor()); // 添加拦截器

class _Interceptor extends InterceptorsWrapper {
  // 请求拦截
  @override
  void onRequest(
    RequestOptions requestOptions,
    RequestInterceptorHandler handler,
  ) {
    // 在请求拦截器中统一设置 loading 弹框
    toast.loading();
    handler.next(requestOptions);
  }

  // 响应拦截
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // 关闭请求loading
    toast.close();

    if (response.data['code'] == '000001') {
      // 跳转至登陆页
    } else if (response.data['code'] != 'SUC') {
      // 统一错误处理，弹窗提示错误信息
    } else {
      // 请求成功正常向下执行
      handler.next(response);
    }
  }

  // 请求错误拦截
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.connectTimeout) {
      // 连接超时，弹窗提示连接超时
      toast.err('connect timeout'.tr);
    } else if (err.type == DioErrorType.receiveTimeout) {
      // 数据接收超时，弹窗提示
      toast.err('receive timeout'.tr);
    } else if (err.type == DioErrorType.sendTimeout) {
      // 数据发送超时，弹窗提示
    } else if (err.type == DioErrorType.cancel) {
      // 数据发送超时，弹窗提示
      toast.err('send timeout'.tr);
    } else {
      // 其他错误，弹窗提示
      toast.err(err.message);
    }
  }
}
