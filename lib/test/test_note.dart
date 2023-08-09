// import 'dart:convert';

import 'package:test/test.dart';
import 'package:measure_group/classes/class_note.dart';

void main() {
  var testData = {
    'notes': [
      {
        "date": "18 June 1982",
        "note":
            "This is a sample note. I'm unsure how multi-lin}e stuff will work"
      },
      {"date": "17 Jan 2023", "note": "Another note"}
    ]
  };
  test("new object should return a date as a string", (() {
    //Map<String, dynamic> userMap = jsonDecode(test_data);
    final note = Note.fromJson(testData['notes']![0]);
    expect(note.date, "18 June 1982");
  }));

  test('new Note object should return some string from .note', ((() {
    final note = Note.fromJson(testData['notes']![0]);
    expect(note.note,
        "This is a sample note. I'm unsure how multi-lin}e stuff will work");
  })));

  test('verifies mulitple notes were constructed', (() {
    List objectList = [];
    for (var note in testData['notes']!) {
      objectList.add(Note.fromJson(note));
    }
    expect(objectList.length, 2);
  }));

  test('checks property for object2', (() {
    List objectList = [];
    for (var note in testData['notes']!) {
      objectList.add(Note.fromJson(note));
    }
    expect(objectList[1].note, "Another note");
  }));

  test("test toJson function for single object", (() {
    final note = Note.fromJson(testData['notes']![0]);
    final fromJson = note.toJson();

    expect(fromJson, {
      "date": "18 June 1982",
      "note":
          "This is a sample note. I'm unsure how multi-lin}e stuff will work"
    });
  }));

  test("rebuilds testData.json from objects", (() {
    final note1 = Note.fromJson(testData['notes']![0]);
    final fromJson1 = note1.toJson();
    final note2 = Note.fromJson(testData['notes']![1]);
    final fromJson2 = note2.toJson();

    final newJson = {"notes": []};
    // if the notes list is built outside the JSON object, the object will
    // have artifacts from the process and will be incorrect
    newJson['notes']!.add(fromJson1);
    newJson['notes']!.add(fromJson2);

    expect(newJson, testData);
  }));
}
