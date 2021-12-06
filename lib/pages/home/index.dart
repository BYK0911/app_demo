import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('map'.tr),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Get.toNamed('/display');
          },
          child: const Text('To display page'),
        ),
      ),
    );
  }
}
