import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_bullet.dart';
import 'package:measure_group/classes/class_powder.dart';
import 'package:measure_group/classes/class_brass.dart';
import 'package:measure_group/classes/class_primer.dart';
import 'package:measure_group/classes/class_test.dart';

const String emptyStr = "";

Cartridge createSingleLoadObj() {
  final newBullet = Bullet(
      bulletWeight: emptyStr,
      bulletManufacture: emptyStr,
      bulletName: emptyStr,
      bulletCaliber: emptyStr,
      bulletDiameter: emptyStr,
      bulletLotNumber: emptyStr,
      g1bc: emptyStr,
      g7bc: emptyStr,
      bulletNotes: []);

  final newPowder = Powder(
      powderManufacture: emptyStr,
      powderName: emptyStr,
      powderLotNumber: emptyStr,
      powderNotes: []);

  final newBrass = Brass(
      brassManufacture: emptyStr,
      numOfFirings: emptyStr,
      brassLotNumber: emptyStr,
      brassNotes: []);

  final newPrimer = Primer(
      primerManufacture: emptyStr,
      primerName: emptyStr,
      primerLotNumber: emptyStr,
      primerNotes: []);

  final newCartridge = Cartridge(
      bullet: newBullet,
      powder: newPowder,
      brass: newBrass,
      primer: newPrimer,
      trimLength: emptyStr,
      coal: emptyStr,
      cbto: emptyStr,
      powderWeight: emptyStr,
      notes: [],
      fireArms: [],
      tests: []);

  return newCartridge;
}
