import 'package:get/get.dart';
import 'locales/zh_cn.dart';
import 'locales/en_us.dart';
import 'locales/zh_tw.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_cn': zhCN,
        'en': enUS,
        'zh_tw': zhTW,
      };
}
