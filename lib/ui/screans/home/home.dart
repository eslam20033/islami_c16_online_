import 'package:flutter/material.dart';
import 'package:islami/ui/screans/home/tabs/ahadeth/ahadeth_tab.dart';
import 'package:islami/ui/screans/home/tabs/azkar/azkar_tab.dart';
import 'package:islami/ui/screans/home/tabs/quran/quran_tab.dart';
import 'package:islami/ui/screans/home/tabs/radio/radio_tab.dart';
import 'package:islami/ui/screans/home/tabs/sebha/sebha_tab.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class Home extends StatefulWidget {
  static const routeName = 'Home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    QuranTab(),
    AhadethTab(),
    SebhaTab(),
    RadioTab(),
    AzkarTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.black,
      iconSize: 30,
      selectedLabelStyle: AppTextStyel.whiteBold12,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(
            AppAssets.icQuaran,
            selectedIndex == 0,
          ),
          label: 'Quran',
        ),
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(
            AppAssets.icAhadeth,
            selectedIndex == 1,
          ),
          label: 'Ahadeth',
        ),
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(
            AppAssets.icSebha,
            selectedIndex == 2,
          ),
          label: 'Sebha',
        ),
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(
            AppAssets.icRadio,
            selectedIndex == 3,
          ),
          label: 'Radio',
        ),
        BottomNavigationBarItem(
          icon: buildBottomNavigationBarIcon(
            AppAssets.icAzkar,
            selectedIndex == 4,
          ),
          label: 'Azkar',
        ),
      ],
    );
  }

  Widget buildBottomNavigationBarIcon(String icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 29),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blackWithOpacity60 : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ImageIcon(AssetImage(icon)),
    );
  }
}
