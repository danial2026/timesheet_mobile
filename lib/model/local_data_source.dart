import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  String TOKEN = "TOKEN";


  void saveToken(String token)async{
    SharedPreferences cash = await SharedPreferences.getInstance();
    cash.setString(TOKEN, token);
  }

  Future<String?> getToken()async{
    SharedPreferences cash = await SharedPreferences.getInstance();
    return cash.getString(TOKEN);
  }
}