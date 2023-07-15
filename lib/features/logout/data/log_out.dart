import 'package:shared_preferences/shared_preferences.dart';

class Logout {
  Future removeSavedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove('name');
    prefs.remove('date');
  }
}
