import 'package:islami/model/sura_model.dart';
import 'package:islami/ui/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

abstract final class MostRecentSurasPrefs {
  static const suraKey = "suras";
  static List<SuraDM> surasList = [];

  static Future loadSurasList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentSurasList = prefs.getStringList(suraKey) ?? [];
    surasList = currentSurasList
        .map((String) => AppConstants.suras[int.parse(String) - 1])
        .toList()
        .reversed
        .toList();
  }

  static Future addSuraToPrefs(SuraDM sura) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? oldSuras = prefs.getStringList(suraKey) ?? [];
    if (oldSuras.contains(sura.index.toString())) {
      oldSuras.remove(sura.index.toString());
      oldSuras.add(sura.index.toString());
    } else {
      oldSuras.add(sura.index.toString());
    }

    prefs.setStringList(suraKey, oldSuras);
    await loadSurasList();
  }
}
