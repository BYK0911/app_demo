import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('display'.tr),
      ),
    );
  }
}
