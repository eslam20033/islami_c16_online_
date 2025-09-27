import 'package:flutter/material.dart';
import 'package:islami/ui/screans/home/tabs/quran/sura_row.dart';
import 'package:islami/ui/screans/sura_details/sura_details.dart';
import 'package:islami/ui/utils/app_assets.dart';
import 'package:islami/ui/utils/app_colors.dart';
import 'package:islami/ui/utils/app_constants.dart';
import 'package:islami/ui/utils/app_text_styles.dart';
import 'package:islami/ui/utils/most_recent_suras_prefs.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<dynamic> filteredSurasList = AppConstants.suras;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    MostRecentSurasPrefs.loadSurasList().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.quranBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: Image.asset(AppAssets.islamiLogo, fit: BoxFit.contain),
            ),
            SizedBox(height: 20),
            buildSearchTextField(),
            SizedBox(height: 20),
            Text("Most Recent", style: AppTextStyel.whiteBold12),
            SizedBox(height: 10),
            if (MostRecentSurasPrefs.surasList.isNotEmpty)
              SizedBox(height: 140, child: buildMostRecentList()),
            SizedBox(height: 10),
            Text("Suras List", style: AppTextStyel.whiteBold12),
            SizedBox(height: 10),
            Expanded(child: buildFilteredSurasListView()),
          ],
        ),
      ),
    );
  }

  Widget buildMostRecentList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: MostRecentSurasPrefs.surasList.length,
      itemBuilder: (context, index) {
        var sura = MostRecentSurasPrefs.surasList[index];
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(18),
          ),
          child: InkWell(
            onTap: () async {
              await Navigator.pushNamed(
                context,
                SuraDetails.routename,
                arguments: sura,
              );
              if (mounted) {
                setState(() {});
              }
            },
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          sura.nameEn,
                          style: AppTextStyel.blackBold24,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          sura.nameAr,
                          style: AppTextStyel.blackBold24,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          "${sura.verses} verses",
                          style: AppTextStyel.blackBold16,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: double.infinity,
                      child: Image.asset(
                        AppAssets.recentSura,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchTextField() {
    var defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gold, width: 2),
      borderRadius: BorderRadius.circular(16),
    );

    return Container(
      child: TextField(
        controller: searchController,
        onChanged: (searchKey) {
          filterSuraListBySearchKey(searchKey);
        },
        decoration: InputDecoration(
          border: defaultBorder,
          focusedBorder: defaultBorder,
          enabledBorder: defaultBorder,
          labelText: "Sura Name",
          labelStyle: TextStyle(fontSize: 18, color: AppColors.gold),
          prefixIcon: ImageIcon(
            AssetImage(AppAssets.icQuaran),
            color: AppColors.gold,
            size: 28,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        cursorColor: AppColors.gold,
        maxLines: 1,
      ),
    );
  }

  Widget buildFilteredSurasListView() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: filteredSurasList.length,
      itemBuilder: (context, index) {
        var sura = filteredSurasList[index];
        return InkWell(
          onTap: () async {
            MostRecentSurasPrefs.addSuraToPrefs(sura);
            await Navigator.pushNamed(
              context,
              SuraDetails.routename,
              arguments: sura,
            );
            if (mounted) {
              setState(() {});
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: SuraRow(sura: sura),
          ),
        );
      },
      separatorBuilder: (_, __) =>
          Divider(indent: 64, endIndent: 64, color: Colors.white, thickness: 2),
    );
  }

  void filterSuraListBySearchKey(String searchKey) {
    if (searchKey.isEmpty) {
      filteredSurasList = AppConstants.suras;
    } else {
      filteredSurasList = AppConstants.suras.where((sura) {
        return sura.nameEn.toLowerCase().contains(searchKey.toLowerCase()) ||
            sura.nameAr.contains(searchKey);
      }).toList();
    }

    setState(() {});
  }
}
