import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as log;

dynamic get(String prefName) async {
  // TODO: build error catching. What if no prefernce?
  final pref = await SharedPreferences.getInstance();
  return pref.get(prefName) ?? "No preference set";
}

Future<int> set(String prefName, dynamic prefValue) async {
  final pref = await SharedPreferences.getInstance();
  Type checkThis = prefValue.runtimeType;

  switch (checkThis) {
    case String:
      {
        pref.setString(prefName, prefValue);
        break;
      }
    case bool:
      {
        pref.setBool(prefName, prefValue);
        break;
      }
    case int:
      {
        pref.setInt(prefName, prefValue);
        break;
      }
    case double:
      {
        pref.setDouble(prefName, prefValue);
        break;
      }
    case List<String>:
      {
        pref.setStringList(prefName, prefValue);
        break;
      }
    default:
      {
        log.log('failed to add preference', name: 'prefBot');
        return 1;
      }
  }
  return 0;
}

void del(String prefName) async {
  try {
    final pref = await SharedPreferences.getInstance();
    pref.remove(prefName);
  } catch (e) {
    log.log('this was the error: $e', name: 'prefBot');
  }
}
