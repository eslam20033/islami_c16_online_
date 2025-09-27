import 'package:flutter/material.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'dart:math';

class SebhaTab extends StatefulWidget {
  static const routeName = "SebhaTab";
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> with TickerProviderStateMixin {
  int counter = 0;
  int phraseIndex = 0;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  List<String> phrases = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: pi / 6, // دوران 30 درجة
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      counter++;
      if (counter % 30 == 0) {
        phraseIndex = (phraseIndex + 1) % phrases.length;
      }
    });

    // تشغيل الدوران
    _rotationController.forward().then((_) {
      _rotationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final logoHeight = screenHeight * 0.2;
    final sebhaSize = min(screenWidth, screenHeight) * 0.9;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.sebhaBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),

                // Logo
                Image.asset(
                  AppAssets.islamiLogo,
                  width: screenWidth * 0.9,
                  height: logoHeight,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 10),

                // Title
                const Text(
                  "سبح اسم ربك الأعلى",
                  style: TextStyle(
                    fontFamily: "JannaLT",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),

                // Sebha مع الدوران
                GestureDetector(
                  onTap: _incrementCounter,
                  child: SizedBox(
                    width: sebhaSize,
                    height: sebhaSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // السبحة اللي بتلف
                        AnimatedBuilder(
                          animation: _rotationAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: Image.asset(
                                AppAssets.sebhaBd,
                                width: sebhaSize * 0.76,
                                height: sebhaSize * 0.76,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                        // النص والعداد (ثابتين تماماً)
                        Positioned(
                          top: sebhaSize / 2 - 30,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Text(
                                phrases[phraseIndex],
                                style: const TextStyle(
                                  fontFamily: "JannaLT",
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "$counter",
                                style: const TextStyle(
                                  fontFamily: "JannaLT",
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
