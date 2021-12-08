import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 提示类型
enum _TipType { success, error, info }

class HsToast {
  static final FToast _toast = FToast();

  // 设置提示的上下文
  setContext(BuildContext context) {
    _toast.init(context);
  }

  // 清除toast
  void close() {
    _toast.removeCustomToast();
  }

  // 正确提示
  void ok(String msg) {
    tip(msg, type: _TipType.success);
  }

  // 异常提示
  void err(String msg) {
    tip(msg, type: _TipType.error);
  }

  // 一般提示
  void info(String msg) {
    tip(msg, type: _TipType.info);
  }

  // 简单消息提示
  void tip(String msg, {_TipType type = _TipType.info}) {
    close();
    _toast.showToast(
      child: Container(
        decoration: BoxDecoration(
          color: _getTipBackgroundColor(type),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      gravity: ToastGravity.TOP,
    );
  }

  // 加载提示
  void loading() {
    close();
    _toast.showToast(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color.fromARGB(100, 200, 200, 200),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text('loading...'),
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(days: 1),
    );
  }

  // 自定义消息提示
  void toast({
    required Widget child,
    Widget Function(BuildContext, Widget)? positionedToastBuilder,
    Duration? toastDuration,
    ToastGravity? gravity,
    int fadeDuration = 350,
  }) {
    close();
    _toast.showToast(
      child: child,
      positionedToastBuilder: positionedToastBuilder,
      toastDuration: toastDuration,
      gravity: gravity,
      fadeDuration: fadeDuration,
    );
  }
}

// 获取提示类型对应的背景颜色
Color _getTipBackgroundColor(_TipType type) {
  switch (type) {
    case _TipType.success:
      return const Color.fromARGB(200, 100, 220, 100);
    case _TipType.error:
      return const Color.fromARGB(200, 220, 100, 100);
    case _TipType.info:
      return const Color.fromARGB(200, 100, 100, 100);
  }
}

HsToast toast = HsToast();
