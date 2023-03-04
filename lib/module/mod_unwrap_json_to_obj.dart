import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';

// IN: json data for creating objects
// OUT: List with nested lists = [loadList, fireArmList]
List unwrap(Map<String, dynamic> data) {
  List<Cartridge> loadList = [];
  List<FireArm> fireArmList = [];
  data['loads'].forEach((load) {
    loadList.add(Cartridge.fromJson(load));
  });

  data['fireArms'].forEach((fireArm) {
    fireArmList.add(FireArm.fromJson(fireArm));
  });
  List list = [loadList, fireArmList];
  return list;
}
