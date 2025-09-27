import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islami/ui/screans/home/home.dart';
import 'package:islami/ui/utils/app_assets.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const routeName = 'Splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Home.routeName);
    });
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          AppAssets.splashImage,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
