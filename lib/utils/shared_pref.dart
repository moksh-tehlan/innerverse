import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  factory SharedPref(){
    return _singleton;
  }

  SharedPref._internal(){
    init();
  }
  static late SharedPreferences _prefs;
  static final _singleton = SharedPref._internal();

  static Future<void> init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setOnBoardingVisited(bool isVisited)async{
    await _prefs.setBool('onBoardingVisited', isVisited);
  }

  static bool getOnBoardingVisited(){
    return _prefs.getBool('onBoardingVisited') ?? false;
  }
}
