import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart' show CarouselSlider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/ui/screans/hadeth_details/hadeth_details.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class Hadeth {
  String title;
  String content;
  Hadeth(this.title, this.content);
}

class AhadethTab extends StatefulWidget {
  const AhadethTab({super.key});

  @override
  State<AhadethTab> createState() => _AhadethTabState();
}

class _AhadethTabState extends State<AhadethTab> {
  List<Hadeth> ahadeth = [];

  @override
  void initState() {
    super.initState();
    readAhadethFile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.ahadethBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: Image.asset(AppAssets.islamiLogo, fit: BoxFit.contain),
          ),
          SizedBox(height: 20),
          if (ahadeth.isNotEmpty)
            Flexible(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: constraints.maxHeight,
                    child: CarouselSlider.builder(
                      itemCount: ahadeth.length,
                      options: CarouselOptions(
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        height: constraints.maxHeight - 40,
                        scrollDirection: Axis.horizontal,
                        enlargeFactor: .1,
                        viewportFraction: 0.8,
                      ),
                      itemBuilder:
                          (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) {
                            return buildHadethWidget(itemIndex);
                          },
                    ),
                  );
                },
              ),
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildHadethWidget(int itemIndex) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          HadethDetails.routename,
          arguments: ahadeth[itemIndex],
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.hadethBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Container(
              constraints: BoxConstraints(maxHeight: 60),
              child: Text(
                ahadeth[itemIndex].title,
                style: AppTextStyel.blackBold24,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        ahadeth[itemIndex].content,
                        style: AppTextStyel.blackBold16,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void readAhadethFile() async {
    try {
      String ahadethFile = await rootBundle.loadString(
        "assets/files/ahadeth.txt",
      );
      List<String> ahadethList = ahadethFile.split("#\r\n");

      for (int i = 0; i < ahadethList.length; i++) {
        String hadeth = ahadethList[i].trim();
        if (hadeth.isEmpty) continue;

        List<String> hadethLines = hadeth.split("\n");
        if (hadethLines.isNotEmpty) {
          String title = hadethLines.removeAt(0).trim();
          String content = hadethLines.join("\n").trim();

          if (title.isNotEmpty && content.isNotEmpty) {
            ahadeth.add(Hadeth(title, content));
          }
        }
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('خطأ في قراءة ملف الأحاديث: $e');
    }
  }
}
