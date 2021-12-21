import 'package:flutter/material.dart';
import 'package:get/get.dart';

@immutable
class I18nTextPage extends StatelessWidget {
  I18nTextPage({Key? key}) : super(key: key);

  final List<List<String?>> langs = [
    ['en', null],
    ['zh', 'cn'],
    ['zh', 'tw'],
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('i18n test'),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('toggle language'),
        onPressed: () {
          index += 1;
          if (index > 2) index = 0;
          print(langs[index][0]);
          Locale locale = Locale((langs[index][0] as String), langs[index][1]);
          Get.updateLocale(locale);
          print(locale);
          print('langCode: ' + locale.languageCode);
          print('coountryCode: ' + locale.countryCode.toString());
        },
      ),
      body: Center(
        child: Text(
          'map'.tr,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
