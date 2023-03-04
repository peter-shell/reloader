import 'dart:ffi';

import 'package:test/test.dart';
import 'package:measure_group/module/mod_pref_bot.dart' as prefBot;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  const String myString = 'check for me';
  const bool myBool = true;
  const int myInt = 12;
  const double myDouble = 12.2;
  const List<String> myList = ['1st string', 'second string', '3rd string'];

  test('checks for correct null response on .get', () async {
    expect("No preference set", await prefBot.get('anything'));
  });

  test('sets a string then checks for it', () async {
    prefBot.set('thatSetting', myString);
    expect(myString, await prefBot.get('thatSetting'));
  });

  test('deletes and confirms deletion of setting', () async {
    prefBot.del('thatSetting');
    expect("No preference set", await prefBot.get('thatSetting'));
  });

  test('sets a bool then checks for it', () async {
    prefBot.set('thatSetting', myBool);
    expect(myBool, await prefBot.get('thatSetting'));
  });

  test('sets a int then checks for it', () async {
    prefBot.set('thatSetting', myInt);
    expect(myInt, await prefBot.get('thatSetting'));
  });

  test('sets a double then checks for it', () async {
    prefBot.set('thatSetting', myDouble);
    expect(myDouble, await prefBot.get('thatSetting'));
  });

  test('sets a list then checks for it', () async {
    prefBot.set('thatSetting', myList);
    expect(myList, await prefBot.get('thatSetting'));
  });

  test('sets an invalid var type then checks for error message', () async {
    var results = await prefBot.set('thatSetting', [12, 23]);
    expect(1, results);
  });
}
