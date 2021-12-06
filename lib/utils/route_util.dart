/// 路由拦截
/// 路由发生变化时，执行某些业务逻辑
///
/// 用法示例：
/// import '[path]/route_util.dart;
///
/// RouteUtil.instance.changeStream.listen((event) {
///   // 要执行的业务逻辑
/// });

import 'dart:async';
import 'package:flutter/material.dart';

class RouteInterceptor extends RouteObserver {
  void _sendScreenView(
    PageRoute<dynamic> route,
    RouteActionType type,
    oldRoute,
  ) {
    RouteUtil().pushRouteDetail(
      RouteEvent(type, route, oldRoute),
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route, RouteActionType.push, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute, RouteActionType.replace, oldRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute, RouteActionType.pop, previousRoute);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute, RouteActionType.remove, previousRoute);
    }
  }
}

class RouteEvent {
  PageRoute<dynamic>? route;
  RouteActionType type;
  PageRoute<dynamic>? oldRoute;
  RouteEvent(this.type, this.route, this.oldRoute);
}

enum RouteActionType { push, replace, pop, remove }

class RouteUtil {
  factory RouteUtil() => _instance;

  static final RouteUtil _instance = RouteUtil._internal();
  static RouteUtil get instance => _instance;
  late StreamController _controller;
  late Stream _stream;
  StreamController get ctrl => _controller;
  Stream get changeStream => _stream;

  RouteUtil._internal() {
    _controller = StreamController.broadcast();
    _stream = _controller.stream;
  }

  void pushRouteDetail(dynamic data) => _controller.sink.add(data);
  void disposeStream() => _controller.close();
}
