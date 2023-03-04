import 'package:measure_group/classes/class_note.dart';
import 'package:measure_group/classes/class_firearms.dart';

class Load {
  String caliber;
  String bulletWeight;
  String bulletManufacture;
  String bulletName;
  String powderWeight;
  String powderType;
  String brassManufacture;
  String numOfFirings;
  String trimLength;
  String coal;
  String cbto;
  String primerManufacture;
  String primerName;
  List fireArms;
  List notes;
  // maybe add list of tests?
  // all the properties below are optional
  String bulletLotNumber;
  String powderLotNumber;
  String primerLotNumber;
  String brassLotNumber;
  String g1bc;
  String g7bc;

  Load({
    required this.caliber,
    required this.bulletWeight,
    required this.bulletManufacture,
    required this.bulletName,
    required this.powderWeight,
    required this.powderType,
    required this.brassManufacture,
    required this.numOfFirings,
    required this.primerManufacture,
    required this.primerName,
    required this.bulletLotNumber,
    required this.powderLotNumber,
    required this.primerLotNumber,
    required this.brassLotNumber,
    required this.g1bc,
    required this.g7bc,
    required this.fireArms,
    required this.notes,
    required this.cbto,
    required this.coal,
    required this.trimLength,
  });

  factory Load.fromJson(Map<String, dynamic> data) {
    final caliber = data['caliber'] as String?;
    final bulletWeight = data['bulletWeight'] as String?;
    final bulletManufacture = data['bulletManufacture'] as String?;
    final bulletName = data['bulletName'] as String?;

    final powderType = data['powderType'] as String?;
    final brassManufacture = data['brassManufacture'] as String?;
    final numOfFirings = data['numOfFirings'] as String?;
    final primerManufacture = data['primerManufacture'] as String?;
    final primerName = data['primerName'] as String?;

    // lists
    final tempNotes = [];
    final tempFireArms = [];

    final powderWeight = data['powderWeight'] as String?;
    final bulletLotNumber = data['bulletLotNumber'] as String?;
    final powderLotNumber = data['powderLotNumber'] as String?;
    final primerLotNumber = data['primerLotNumber'] as String?;
    final brassLotNumber = data['brassLotNumber'] as String?;
    final g1bc = data['g1bc'] as String?;
    final g7bc = data['g7bc'] as String?;
    final trimLength = data['trimLength'] as String?;
    final coal = data['coal'] as String?;
    final cbto = data['cbto'] as String?;

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

    return Load(
        caliber: caliber ?? "",
        bulletWeight: bulletWeight ?? "",
        bulletManufacture: bulletManufacture ?? "",
        bulletName: bulletName ?? "",
        powderWeight: powderWeight ?? "",
        powderType: powderType ?? "",
        brassManufacture: brassManufacture ?? "",
        numOfFirings: numOfFirings ?? "",
        primerManufacture: primerManufacture ?? "",
        primerName: primerName ?? "",
        bulletLotNumber: bulletLotNumber ?? "",
        powderLotNumber: powderLotNumber ?? "",
        primerLotNumber: primerLotNumber ?? "",
        brassLotNumber: brassLotNumber ?? "",
        g1bc: g1bc ?? "",
        g7bc: g7bc ?? "",
        fireArms: tempFireArms,
        notes: tempNotes,
        cbto: cbto ?? "",
        trimLength: trimLength ?? "",
        coal: coal ?? "");
  }

  Map<String, dynamic> toJson() => {
        '"caliber"': '"$caliber"',
        '"bulletWeight"': '"$bulletWeight"',
        '"bulletManufacture"': '"$bulletManufacture"',
        '"bulletName"': '"$bulletName"',
        '"powderWeight"': '"$powderWeight"',
        '"powderType"': '"$powderType"',
        '"brassManufacture"': '"$brassManufacture"',
        '"numOfFirings"': '"$numOfFirings"',
        '"primerManufacture"': '"$primerManufacture"',
        '"primerName"': '"$primerName"',
        '"bulletLotNumber"': '"$bulletLotNumber"',
        '"powderLotNumber"': '"$powderLotNumber"',
        '"primerLotNumber"': '"$primerLotNumber"',
        '"brassLotNumber"': '"$brassLotNumber"',
        '"g1bc"': '"$g1bc"',
        '"g7bc"': '"$g7bc"',
        '"trimLength"': '"$trimLength"',
        '"cbto"': '"$cbto"',
        '"coal"': '"$coal"',
        '"fireArms"': fireArms == []
            ? null
            : List<dynamic>.from(fireArms.map((x) => x.toJson())),
        '"notes"': notes == []
            ? null
            : List<dynamic>.from(notes.map((x) => x.toJson())),
      };
}
