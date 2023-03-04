import 'package:measure_group/classes/class_note.dart';

class FireArm {
  String make;
  String model;
  String caliber;
  List notes;
  String serialNumber;

  FireArm({
    required this.make,
    required this.model,
    required this.caliber,
    required this.serialNumber,
    required this.notes,
  });

  factory FireArm.fromJson(Map<String, dynamic> data) {
    final make = data['make'] as String?;
    final model = data['model'] as String?;
    final caliber = data['caliber'] as String?;
    var serialNumber = "";
    final tempNotes = [];

    if (data['serialNumber'] != null) {
      serialNumber = data['serialNumber'];
    }
    if (data['notes'] != null) {
      data['notes'].forEach((note) {
        tempNotes.add(Note.fromJson(note));
      });
    }

    return FireArm(
      make: make ?? "",
      model: model ?? "",
      caliber: caliber ?? "",
      serialNumber: serialNumber,
      notes: tempNotes,
    );
  }
  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "caliber": caliber,
        "serialNumber": serialNumber,
        "notes": notes == []
            ? null
            : List<dynamic>.from(notes.map((x) => x.toJson())),
      };
}
