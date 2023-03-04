import 'package:test/test.dart';
import 'package:measure_group/classes/class_load.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  //TestWidgetsFlutterBinding.ensureInitialized();

  List loadObjects = [];
  List fireArmObjects = [];
  // Fetch content from local json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);

    // loadObjects = data["loads"];
    data['loads'].forEach((load) {
      loadObjects.add(Load.fromJson(load));
    });
    // fireArmObjects = data['fireArms'];
    data['fireArms'].forEach((fireArm) {
      fireArmObjects.add(FireArm.fromJson(fireArm));
    });
  }

  readJson();

  test('confirms JSON import built firearms objects', (() {
    expect(fireArmObjects.length, 2);
  }));
}
