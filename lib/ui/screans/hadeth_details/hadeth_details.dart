import 'package:flutter/material.dart';
import 'package:islami/ui/screans/home/tabs/ahadeth/ahadeth_tab.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class HadethDetails extends StatefulWidget {
  static const routename = "HadethDetails";
  const HadethDetails({super.key});

  @override
  State<HadethDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<HadethDetails> {
  late Hadeth hadeth;
  @override
  Widget build(BuildContext context) {
    hadeth = ModalRoute.of(context)!.settings.arguments as Hadeth;
    // if (suraContent.isEmpty) {
    //   readSuraContent();
    // }

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: AppColors.gold)),
        // title: Text(hadeth.title, style: AppTextStyel.goldBold24),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [

                Image.asset(AppAssets.leftPattern),
                Expanded(
                  child: Text(
                    hadeth.title,
                    style: AppTextStyel.goldBold24,
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(AppAssets.rightPattern)
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(padding: EdgeInsets.all(16),
                child: Text(
                  hadeth.content,
                  style: AppTextStyel.goldBold20,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
          Image.asset(AppAssets.mosqueImage)
        ],
      ),
    );
  }

  // void readSuraContent() async {
  //   String fileName = "assets/files/quran/${sura.index}.txt";
  //   Future<String> contentFuture = rootBundle.loadString(fileName);
  //   suraContent = await contentFuture;
  //   List<String> suraLines = suraContent.trim().split("\n");
  //   for (int i = 0; i < suraLines.length; i++) {
  //     suraLines[i] += "[${i+1}]";
  //   }
  //   suraContent = suraLines.join();
  //   setState(() {});
  //   print(suraContent);
  // }
}
