import 'package:get/get.dart';
import './locales/zh_cn.dart';
import 'locales/en_us.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zhCN,
        'en_US': enUS,
      };
}
