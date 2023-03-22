import 'package:measure_group/classes/class_var_group_linker_test.dart';

class GeneralTest {
  double? best;
  double? average;
  double? worst;
  String testType;
  List<VarGroupLinker>? chargesAndGroups = [];
  GeneralTest([this.testType = ""]);

  factory GeneralTest.fromJson(Map<String, dynamic> data) {
    final testType = data['testType'];
    return GeneralTest(testType);
  }
  Map<String, dynamic> toJson() => {"testType": testType};
}
