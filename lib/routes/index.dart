import 'package:get/get.dart';
import '../pages/home/index.dart';
import '../pages/display/index.dart';
import '../pages/i18n_test/index.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: '/display', page: () => const DisplayPage()),
  GetPage(name: '/i18n', page: () => I18nTextPage()),
];
