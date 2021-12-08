# mars_app
定位和陈列移动端项目

## 目录结构
* docs            -- 文档目录
* assets          -- 资源目录
  * fonts           -- 字体
  * images          -- 图片
* lib             -- 源码
  * apis            -- 接口目录
  * modules         -- 模块目录
  * pages           -- 路由页面
  * utils           -- 工具库
  * widgets         -- 公共 UI 组件
  * main.dart     -- 入口文件
* pubspec.yaml    -- 项目描述文件

## 网络请求
使用 dio 库发起网络请求。
项目中对接口进行统一管理，所有接口都需要先在 apis 目录下定义，然后在页面中使用。
1. 第一步，在 apis 目录下定义接口

```dart
// lib/apis/session.dart

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

```

2. 第二步，在 pages 目录下引入和调用接口


文件顶部引入接口
```dart
// lib/pages/login/index.dart
import '../../apis/session.dart';

// ...
    ElevatedButton(
      onPressed: () async {
        dynamic res = await login('admin', 'admin');
        // ...
      },
      child: Text('login'.tr),
    )
// ...
```

## 图标
使用 flutter 内置图标
```dart
Icon(Icons.person);
```

使用阿里图标
```dart
Icon(IconData(0xe758), fontFamily: 'IconFont')
```

## 国际化
1. 新增语种，在 i18n/locales 目录下定义locale
2. 在相应语种 locale 文件中增加国家化内容
3. 在页面上通过 messageKey.tr 的形式实现国际化

其他常用 Api
* 国际化传参：messageKey.trParams()
* 切语言: Get.updateLocale(Locale(languageCode, countryCode))

## 屏幕适配
1. 文件头部引入依赖
```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

2. 设置尺寸时使用 SizeExtension
```dart
///[ScreenUtil.setWidth]
/// double get w => ScreenUtil().setWidth(this);

///[ScreenUtil.setHeight]
/// double get h => ScreenUtil().setHeight(this);

///[ScreenUtil.radius]
/// double get r => ScreenUtil().radius(this);

///[ScreenUtil.setSp]
/// double get sp => ScreenUtil().setSp(this);

///smart size :  it check your value if it is bigger than your value set your value
///for example you have set 16.sm() , if for your screen 16.sp() bigger than 16 it will  set 16 not 16.sp()
///I think that it is good for save size balance on big sizes of screen
///double get sm => min(toDouble(), sp);

///屏幕宽度的倍数
///Multiple of screen width
/// double get sw => ScreenUtil().screenWidth * this;

///屏幕高度的倍数
///Multiple of screen height
/// double get sh => ScreenUtil().screenHeight * this;
Container(
  width: 200.sp,
  height: .5.sh,
)
```

## 其他
* [Git提交规范](./docs/Git提交规范.md)
* [代码规范](./docs/代码规范.md)

