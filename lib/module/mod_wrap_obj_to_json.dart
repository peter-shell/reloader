import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';

Map<String, dynamic> rewrap(
    List<Cartridge> loadObjs, List<FireArm> fireArmObjs) {
  var rebuild = {"loads": [], "fireArms": []};
  for (var cartridge in loadObjs) {
    rebuild["loads"]!.add(cartridge.toJson());
  }
  for (var fireArm in fireArmObjs) {
    rebuild["fireArms"]!.add(fireArm.toJson());
  }

  return rebuild;
}
