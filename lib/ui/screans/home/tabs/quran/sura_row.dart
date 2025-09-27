import 'package:flutter/material.dart';
import 'package:islami/model/sura_model.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_text_styles.dart';

class SuraRow extends StatelessWidget {
  final SuraDM sura;
  const SuraRow({super.key, required this.sura});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          buildIndexImage(),
          SizedBox(width: 24),
          Expanded(child: buildEnInfo()),
          SizedBox(width: 12),
          buildNameAr(),
        ],
      ),
    );
  }

  Widget buildIndexImage() => Container(
    width: 52,
    height: 52,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppAssets.suraNumberGround),
        fit: BoxFit.contain,
      ),
    ),
    child: Center(
      child: Text(
        sura.index.toString(),
        style: AppTextStyel.whiteBold14,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

  Widget buildEnInfo() => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          sura.nameEn,
          style: AppTextStyel.whiteBold20,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(height: 4),
        Text(
          "${sura.verses} verses",
          style: AppTextStyel.whiteBold14,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

  Widget buildNameAr() => Container(
    constraints: BoxConstraints(maxWidth: 80),
    child: Text(
      sura.nameAr,
      style: AppTextStyel.whiteBold16,
      textAlign: TextAlign.end,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}
