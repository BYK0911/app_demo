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

lib/apis/session.dart
```dart
/// 登录
/// @param {String} username 用户名
/// @param {String} password 密码
/// 
Future<Response<dynamic>> login(String username, String password) {
  return Http().dio.post(
    '/login',
    data: {
      'username': username,
      'password': password,
    },
  );
}

```

2. 第二步，在 pages 目录下调用接口

lib/pages/login/index.dart

文件顶部引入接口
```dart
import '../../apis/session.dart';
```
调用接口方法
```dart
ElevatedButton(
  onPressed: () async{
    dynamic res = await login('admin', 'admin');
    // ...
  },
  child: Text('login'.tr),
)
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

### 其他
* 国际化传参：messageKey.trParams()
* 切语言: Get.updateLocale(Locale(languageCode, countryCode))
