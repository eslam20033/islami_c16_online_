import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/model/sura_model.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class SuraDetails extends StatefulWidget {
  static const routename = "SuraDetails";
  const SuraDetails({super.key});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  late SuraDM sura;
  String suraContent = "";
  @override
  Widget build(BuildContext context) {
    sura = ModalRoute.of(context)!.settings.arguments as SuraDM;
    if (suraContent.isEmpty) {
      readSuraContent();
    }

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
        title: Text(sura.nameEn, style: AppTextStyel.goldBold24),
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
                    sura.nameAr,
                    style: AppTextStyel.goldBold24,
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(AppAssets.rightPattern)
              ],
            ),
          ),
          suraContent.isEmpty
              ? Center(child: CircularProgressIndicator(color: AppColors.gold))
              :
          Expanded(
            child: SingleChildScrollView(
              child: Padding(padding: EdgeInsets.all(16),
                child: Text(
                  suraContent,
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

  void readSuraContent() async {
    String fileName = "assets/files/quran/${sura.index}.txt";
    Future<String> contentFuture = rootBundle.loadString(fileName);
    suraContent = await contentFuture;
    List<String> suraLines = suraContent.trim().split("\n");
    for (int i = 0; i < suraLines.length; i++) {
      suraLines[i] += "[${i+1}]";
    }
    suraContent = suraLines.join();
    setState(() {});
    print(suraContent);
  }
}
