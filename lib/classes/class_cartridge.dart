import 'class_brass.dart';
import 'class_bullet.dart';
import 'class_powder.dart';
import 'class_primer.dart';
import 'class_firearms.dart';
import 'class_note.dart';

class Cartridge {
  Bullet bullet;
  Powder powder;
  Brass brass;
  Primer primer;
  String trimLength;
  String coal;
  String cbto;
  String powderWeight;
  List notes;
  List fireArms;

  Cartridge(
      {required this.bullet,
      required this.powder,
      required this.brass,
      required this.primer,
      required this.trimLength,
      required this.coal,
      required this.cbto,
      required this.powderWeight,
      required this.notes,
      required this.fireArms});

  factory Cartridge.fromJson(Map<String, dynamic> data) {
    final bullet = Bullet.fromJson(data['bullet']);
    final powder = Powder.fromJson(data['powder']);
    final brass = Brass.fromJson(data['brass']);
    final primer = Primer.fromJson(data['primer']);
    final trimLength = data['trimLength'] as String?;
    final coal = data['coal'] as String?;
    final cbto = data['cbto'] as String?;
    final powderWeight = data['powderWeight'] as String?;
    final tempNotes = [];
    final tempFireArms = [];
    if (data['notes'] != null) {
      data['notes'].forEach((note) {
        tempNotes.add(Note.fromJson(note));
      });
    }
    if (data['fireArms'] != null) {
      data['fireArms'].forEach((fireArm) {
        tempFireArms.add(FireArm.fromJson(fireArm));
      });
    }
    return Cartridge(
        bullet: bullet,
        powder: powder,
        brass: brass,
        primer: primer,
        trimLength: trimLength ?? "",
        coal: coal ?? "",
        cbto: cbto ?? "",
        powderWeight: powderWeight ?? "",
        notes: tempNotes,
        fireArms: tempFireArms);
  }
  Map<String, dynamic> toJson() => {
        "bullet": bullet.toJson(),
        "powder": powder.toJson(),
        "brass": brass.toJson(),
        "primer": primer.toJson(),
        "trimLength": trimLength,
        "coal": coal,
        "cbto": cbto,
        "powderWeight": powderWeight,
        "fireArms": fireArms == []
            ? null
            : List<dynamic>.from(fireArms.map((x) => x.toJson())),
        "notes": notes == []
            ? null
            : List<dynamic>.from(notes.map((x) => x.toJson())),
      };
  void update(Map<String, dynamic> loadData) => {null};
}
