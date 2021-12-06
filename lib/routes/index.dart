import 'package:get/get.dart';
import '../pages/home/index.dart';
import '../pages/display/index.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: '/display', page: () => const DisplayPage()),
];
