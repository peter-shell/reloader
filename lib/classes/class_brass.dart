import 'package:measure_group/classes/class_note.dart';

class Brass {
  String brassManufacture;
  String numOfFirings;
  String brassLotNumber;
  List brassNotes;

  Brass(
      {required this.brassManufacture,
      required this.numOfFirings,
      required this.brassLotNumber,
      required this.brassNotes});

  factory Brass.fromJson(Map<String, dynamic> data) {
    final brassManufacture = data['brassManufacture'] as String?;
    final numOfFirings = data['numOfFirings'] as String?;
    final brassLotNumber = data['brassLotNumber'] as String?;
    final tempBrassNotes = [];
    if (data['brassNotes'] != null) {
      data['brassNotes'].forEach((note) {
        tempBrassNotes.add(Note.fromJson(note));
      });
    }
    return Brass(
        brassManufacture: brassManufacture ?? "",
        numOfFirings: numOfFirings ?? "",
        brassLotNumber: brassLotNumber ?? "",
        brassNotes: tempBrassNotes);
  }
  Map<String, dynamic> toJson() => {
        "brassManufacture": brassManufacture,
        "numOfFirings": numOfFirings,
        "brassLotNumber": brassLotNumber,
        "brassNotes": brassNotes == []
            ? null
            : List<dynamic>.from(brassNotes.map((x) => x.toJson())),
      };
}
