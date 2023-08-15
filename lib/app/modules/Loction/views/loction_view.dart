import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/loction_controller.dart';

class LoctionView extends GetView<LoctionController> {
  const LoctionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoctionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LoctionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
