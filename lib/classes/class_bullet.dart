import 'package:measure_group/classes/class_note.dart';

class Bullet {
  String bulletWeight;
  String bulletManufacture;
  String bulletName;
  String bulletCaliber;
  String bulletDiameter;
  String bulletLotNumber;
  String g1bc;
  String g7bc;
  List bulletNotes;

  Bullet(
      {required this.bulletWeight,
      required this.bulletManufacture,
      required this.bulletName,
      required this.bulletCaliber,
      required this.bulletDiameter,
      required this.bulletLotNumber,
      required this.g1bc,
      required this.g7bc,
      required this.bulletNotes});
  factory Bullet.fromJson(Map<String, dynamic> data) {
    final bulletWeight = data['bulletWeight'] as String?;
    final bulletManufacture = data['bulletManufacture'] as String?;
    final bulletName = data['bulletName'] as String?;
    final bulletCaliber = data['bulletCaliber'] as String?;
    final bulletDiameter = data['bulletDiameter'] as String?;
    final bulletLotNumber = data['bulletLotNumber'] as String?;
    final g1bc = data['g1bc'] as String?;
    final g7bc = data['g7bc'] as String?;
    final tempBulletNotes = [];

    if (data['bulletNotes'] != null) {
      (data['bulletNotes'].forEach((note) {
        tempBulletNotes.add(Note.fromJson(note));
      }));
    }
    return Bullet(
        bulletWeight: bulletWeight ?? "",
        bulletManufacture: bulletManufacture ?? "",
        bulletName: bulletName ?? "",
        bulletCaliber: bulletCaliber ?? "",
        bulletDiameter: bulletDiameter ?? "",
        bulletLotNumber: bulletLotNumber ?? "",
        g1bc: g1bc ?? "",
        g7bc: g7bc ?? "",
        bulletNotes: tempBulletNotes);
  }
  Map<String, dynamic> toJson() => {
        "bulletWeight": bulletWeight,
        "bulletManufacture": bulletManufacture,
        "bulletName": bulletName,
        "bulletCaliber": bulletCaliber,
        "bulletDiameter": bulletDiameter,
        "bulletLotNumber": bulletLotNumber,
        "g1bc": g1bc,
        "g7bc": g7bc,
        "bulletNotes": bulletNotes == []
            ? null
            : List<dynamic>.from(bulletNotes.map((x) => x.toJson()))
      };
}
