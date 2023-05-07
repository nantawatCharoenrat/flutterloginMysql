import 'package:shared_preferences/shared_preferences.dart';

class User {

  static Future<bool?> getsignin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("Sing-in");
  }
  static Future setsignin(bool signin) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool("Sing-in",signin);
  }
}