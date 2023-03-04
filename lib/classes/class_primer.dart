import 'package:measure_group/classes/class_note.dart';

class Primer {
  String primerManufacture;
  String primerName;
  String primerLotNumber;
  List primerNotes;

  Primer(
      {required this.primerManufacture,
      required this.primerName,
      required this.primerLotNumber,
      required this.primerNotes});

  factory Primer.fromJson(Map<String, dynamic> data) {
    final primerManufacture = data['primerManufacture'] as String?;
    final primerName = data['primerName'] as String?;
    final primerLotNumber = data['primerLotNumber'] as String?;
    final tempPrimerNotes = [];

    if (data['primerNotes'] != null) {
      data['primerNotes'].forEach((note) {
        tempPrimerNotes.add(Note.fromJson(note));
      });
    }
    return Primer(
        primerManufacture: primerManufacture ?? "",
        primerName: primerName ?? "",
        primerLotNumber: primerLotNumber ?? "",
        primerNotes: tempPrimerNotes);
  }
  Map<String, dynamic> toJson() => {
        "primerManufacture": primerManufacture,
        "primerName": primerName,
        "primerLotNumber": primerLotNumber,
        "primerNotes": primerNotes == []
            ? null
            : List<dynamic>.from(primerNotes.map((x) => x.toJson())),
      };
}
