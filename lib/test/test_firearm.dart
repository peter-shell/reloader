import 'package:measure_group/classes/class_firearms.dart';

import 'package:test/test.dart';

void main() {
  final testData = {
    "fireArms": [
      {
        "make": "American Rifle Company",
        "model": "Nucleous",
        "caliber": "6.5 Creedmoor",
        "serialNumber": "XXXX420",
        "notes": []
      },
      {
        "make": "Remington",
        "model": "700 PSS",
        "caliber": ".308 Winchester",
        "serialNumber": "XXXX6969",
        "notes": [
          {"date": "17 Jan 2023", "note": "Another note"},
          {"date": "17 Jan 2023", "note": "Another note"}
        ]
      }
    ]
  };
  List objectList = [];

  testData['fireArms']!.forEach(
    (fireArm) {
      objectList.add(FireArm.fromJson(fireArm));
    },
  );
  test('did all objects get built?', (() {
    // todo
    expect(objectList.length, 2);
  }));

  test('object 2s make', (() {
    expect(objectList[1].make, "Remington");
  }));

  test('object 2s note.note', (() {
    expect(objectList[1].notes[0].note, "Another note");
  }));
  test('object 2s note.length', (() {
    expect(objectList[1].notes.length, 2);
  }));
}
