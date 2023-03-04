import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_bullet.dart';
import 'package:measure_group/classes/class_powder.dart';
import 'package:measure_group/classes/class_brass.dart';
import 'package:measure_group/classes/class_primer.dart';

Cartridge createSingleLoadObj(Map<String, dynamic> loadData) {
  final newBullet = Bullet(
      bulletWeight: loadData['bulletWeight'] ?? "",
      bulletManufacture: loadData['bulletManufacture'] ?? "",
      bulletName: loadData['bulletName'] ?? "",
      bulletCaliber: loadData['bulletCaliber'] ?? "",
      bulletDiameter: loadData['bulletDiameter'] ?? "",
      bulletLotNumber: loadData['bulletLotNumber'] ?? "",
      g1bc: loadData['g1bc'] ?? "",
      g7bc: loadData['g7bc'] ?? "",
      bulletNotes: []);

  final newPowder = Powder(
      powderManufacture: loadData['powderManufacture'] ?? "",
      powderName: loadData['powderName'] ?? "",
      powderLotNumber: loadData['powderLotNumber'] ?? "",
      powderNotes: []);

  final newBrass = Brass(
      brassManufacture: loadData['brassManufacture'] ?? "",
      numOfFirings: loadData['numOfFirings'] ?? "",
      brassLotNumber: loadData['brassLotNumber'] ?? "",
      brassNotes: []);

  final newPrimer = Primer(
      primerManufacture: loadData['primerManufacture'] ?? "",
      primerName: loadData['primerName'] ?? "",
      primerLotNumber: loadData['primerLotNumber'] ?? "",
      primerNotes: []);

  final newCartridge = Cartridge(
      bullet: newBullet,
      powder: newPowder,
      brass: newBrass,
      primer: newPrimer,
      powderWeight: loadData['powderWeight'] ?? "",
      trimLength: loadData['trimLength'] ?? "",
      coal: loadData['coal'] ?? "",
      cbto: loadData['cbto'] ?? "",
      notes: [],
      fireArms: []);

  return newCartridge;
}
