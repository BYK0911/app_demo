import 'package:dio/dio.dart';
import './http.dart';

/// 登录
/// @param {String} username 用户名
/// @param {String} password 密码
///
Future<Response<dynamic>> login(String username, String password) {
  return dio.post(
    '/login',
    data: {
      'username': username,
      'password': password,
    },
  );
}
