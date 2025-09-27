import 'package:flutter/material.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_colors.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  int selectedTab = 0;
  int? playingIndex;

  List<RadioStation> radioStations = [
    RadioStation(
      name: "إذاعة إبراهيم الأخضر",
      nameEn: "Ibrahim Al-Akdar",
      isPlaying: false,
    ),
    RadioStation(
      name: "إذاعة القارئ ياسين",
      nameEn: "Al-Qaria Yassen",
      isPlaying: false,
    ),
    RadioStation(
      name: "إذاعة أحمد الطرابلسي",
      nameEn: "Ahmed Al-trabulsi",
      isPlaying: false,
    ),
    RadioStation(
      name: "إذاعة الدوكالي محمد العالم",
      nameEn: "Addokali Mohammad Alalim",
      isPlaying: false,
    ),
  ];

  List<RadioStation> reciters = [
    RadioStation(
      name: "Ibrahim Al-Akdar",
      nameEn: "Ibrahim Al-Akdar",
      isPlaying: false,
    ),
    RadioStation(
      name: "Akram Alalaqmi",
      nameEn: "Akram Alalaqmi",
      isPlaying: false,
    ),
    RadioStation(
      name: "Majed Al-Enezi",
      nameEn: "Majed Al-Enezi",
      isPlaying: false,
    ),
    RadioStation(
      name: "Malik shaibat Alhamed",
      nameEn: "Malik shaibat Alhamed",
      isPlaying: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.quranBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: Image.asset(AppAssets.islamiLogo, fit: BoxFit.contain),
              ),
              SizedBox(height: 20),
              buildTabButtons(),
              SizedBox(height: 20),
              Expanded(child: buildStationsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: buildTabButton("Radio", 0)),
          SizedBox(width: 10),
          Expanded(child: buildTabButton("Reciters", 1)),
        ],
      ),
    );
  }

  Widget buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
          playingIndex = null;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gold, width: 2),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : AppColors.gold,
          ),
        ),
      ),
    );
  }

  Widget buildStationsList() {
    List<RadioStation> currentList = selectedTab == 0
        ? radioStations
        : reciters;

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: currentList.length,
      itemBuilder: (context, index) {
        return buildStationCard(currentList[index], index);
      },
    );
  }

  Widget buildStationCard(RadioStation station, int index) {
    bool isPlaying = playingIndex == index;

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            selectedTab == 0 ? station.name : station.nameEn,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 15),

          SizedBox(
            height: 50,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (!isPlaying)
                  Opacity(
                    opacity: 0.9,
                    child: Image.asset(
                      'assets/images/mosque_image.png',
                      fit: BoxFit.fitWidth,
                      color: Colors.black,
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(child: buildSoundWaves(true)),
                      SizedBox(width: 100),
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: buildSoundWaves(true),
                        ),
                      ),
                    ],
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isPlaying) {
                            playingIndex = null;
                          } else {
                            playingIndex = index;
                          }
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.gold,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.volume_up,
                        color: AppColors.gold,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSoundWaves(bool isAnimated) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(15, (index) {
        double height = isAnimated
            ? (10 + (index % 4) * 8).toDouble()
            : (5 + (index % 3) * 3).toDouble();

        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 50)),
          curve: Curves.easeInOut,
          width: 3,
          height: height,
          decoration: BoxDecoration(
            color: isAnimated
                ? Colors.black.withOpacity(0.8)
                : Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

class RadioStation {
  final String name;
  final String nameEn;
  bool isPlaying;

  RadioStation({
    required this.name,
    required this.nameEn,
    this.isPlaying = false,
  });
}
