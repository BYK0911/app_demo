/// TopSheet/BottomSheet
///
/// 用法：
/// sheet.open(
///   context,
///   child: childWidget,
///   position: SheetPosition.top,
///   backdrop: true,
///   dismissable: true
/// )
///
/// sheet.close()

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SheetPosition {
  top,
  bottom,
}

late AnimationController _animationController;

class _SheetUtil {
  OverlayEntry? _entry;
  bool _sheetOpened = false;

  open(
    BuildContext context, {
    required Widget child,
    SheetPosition position = SheetPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.white,
    bool backdrop = true,
    bool dismissable = true,
  }) async {
    if (_sheetOpened) {
      await close();
    }

    _entry = OverlayEntry(
      builder: (context) => _sheetBuilder(
        context,
        child,
        position,
        backgroundColor,
        backdrop,
        dismissable,
      ),
    );

    Overlay.of(context)!.insert(_entry!);

    _sheetOpened = true;
  }

  close() async {
    if (_sheetOpened) {
      await _animationController.fling(velocity: -1.0);
      _entry?.remove();
      _entry = null;
      _sheetOpened = false;
    }
  }
}

Widget _sheetBuilder(BuildContext context, Widget child, SheetPosition position,
    Color backgroundColor, bool backdrop, bool dismissable) {
  Widget sheet = _SheetWidget(
    child: child,
    position: position,
    backgroundColor: backgroundColor,
    backdrop: backdrop,
    dismissable: dismissable,
  );
  switch (position) {
    case SheetPosition.top:
      return Positioned(child: sheet, top: 0, left: 0, right: 0);
    case SheetPosition.bottom:
      return Positioned(child: sheet, bottom: 0, left: 0, right: 0);
  }
}

class _SheetWidget extends StatefulWidget {
  final Widget child;
  final SheetPosition position;
  final Color backgroundColor;
  final bool backdrop;
  final bool dismissable;

  const _SheetWidget(
      {Key? key,
      required this.child,
      required this.position,
      required this.backgroundColor,
      required this.backdrop,
      required this.dismissable})
      : super(key: key);

  @override
  __SheetWidgetState createState() => __SheetWidgetState();
}

class __SheetWidgetState extends State<_SheetWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ).addListener(() {
      setState(() {});
    });
    _animationController.fling(velocity: 1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int alpha = (_animationController.value * 150).toInt();
    final isTop = widget.position == SheetPosition.top;

    Widget sheetInner = Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: isTop ? Radius.zero : const Radius.circular(10),
          bottom: isTop ? const Radius.circular(10) : Radius.zero,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        heightFactor: _animationController.value,
        child: widget.child,
      ),
    );

    return Material(
      color: Colors.transparent,
      child: widget.backdrop
          ? Stack(
              alignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.dismissable) {
                      sheet.close();
                    }
                  },
                  child: Container(
                    width: 1.sw,
                    height: 1.sh,
                    color: Color.fromARGB(alpha, 0, 0, 0),
                  ),
                ),
                sheetInner,
              ],
            )
          : sheetInner,
    );
  }
}

_SheetUtil sheet = _SheetUtil();
