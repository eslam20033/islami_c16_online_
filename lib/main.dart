import 'package:flutter/material.dart';
import 'package:islami/ui/screans/hadeth_details/hadeth_details.dart';
import 'package:islami/ui/screans/home/home.dart';
import 'package:islami/ui/screans/home/tabs/sebha/sebha_tab.dart';
import 'package:islami/ui/screans/splash/splash.dart';
import 'package:islami/ui/screans/sura_details/sura_details.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_constants.dart';

void main() {
  AppConstants.fillSuras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(canvasColor: AppColors.gold),
      initialRoute: Splash.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        Splash.routeName: (_) => const Splash(),
        Home.routeName: (_) => const Home(),
        SuraDetails.routename: (_) => const SuraDetails(),
        HadethDetails.routename: (_) => const HadethDetails(),
        SebhaTab.routeName: (_) => const SebhaTab(),
      },
    );
  }
}
