

import 'package:shared_preferences/shared_preferences.dart';

class SharedHalper 
{
    static late SharedPreferences shared;

    static init() async
    {
      shared = await SharedPreferences.getInstance();
    }

    static Future<bool> putbool(
      {
        required String key, required bool value
      }
    ) async
    {
        return await shared.setBool(key, value); 
    }

    static bool? getBool(String key)
    {
        return shared.getBool(key);
    } 
}