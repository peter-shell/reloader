import 'package:measure_group/classes/class_cartridge.dart';
import 'package:measure_group/classes/class_firearms.dart';
import 'package:test/test.dart';
import 'package:measure_group/module/mod_unwrap_json_to_obj.dart' as unwrap;
import 'package:measure_group/test/updated_data.dart' as data;
import 'package:measure_group/module/mod_wrap_obj_to_json.dart' as rewrap;

// need to confirm construction of fireArms and loads lists, populated with the
// correct objs
// then rebuild the single json file from those objects
void main() {
  var moreData = data.testData;

  List<FireArm> fireArmsList;
  List<Cartridge> loadList;

  List objectList = unwrap.unwrap(moreData);
  fireArmsList = objectList[1];
  loadList = objectList[0];
  var rebuiltData = rewrap.rewrap(loadList, fireArmsList);

  test('tests for correct number of objects in loads', (() {
    expect(moreData, rebuiltData);
  }));
}
