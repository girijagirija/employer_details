import 'package:employer_details/res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.put(Splashcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset(Res.loading,),),
    );
  }
}
