import 'package:measure_group/classes/class_note.dart';

class Powder {
  String powderManufacture;
  String powderName;
  String powderLotNumber;
  List powderNotes;

  Powder({
    required this.powderManufacture,
    required this.powderName,
    required this.powderLotNumber,
    required this.powderNotes,
  });
  factory Powder.fromJson(Map<String, dynamic> data) {
    final powderManufacture = data['powderManufacture'] as String?;
    final powderName = data['powderName'] as String?;
    final powderLotNumber = data['powderLotNumber'] as String?;
    final tempPowderNotes = [];

    if (data['powderNotes'] != null) {
      data['powderNotes'].forEach((note) {
        tempPowderNotes.add(Note.fromJson(note));
      });
    }
    return Powder(
        powderManufacture: powderManufacture ?? "",
        powderName: powderName ?? "",
        powderLotNumber: powderLotNumber ?? "",
        powderNotes: tempPowderNotes);
  }
  Map<String, dynamic> toJson() => {
        "powderManufacture": powderManufacture,
        "powderName": powderName,
        "powderLotNumber": powderLotNumber,
        "powderNotes": powderNotes == []
            ? null
            : List<dynamic>.from(powderNotes.map((x) => x.toJson())),
      };
}
