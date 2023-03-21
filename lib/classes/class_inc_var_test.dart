import 'package:measure_group/classes/class_test.dart';
import 'package:measure_group/classes/class_var_group_linker_test.dart';

class IncrementVarTest extends GeneralTest {
  List<VarGroupLinker> varGroupList = [];
  double smallestGroup;

  IncrementVarTest({required this.varGroupList, required this.smallestGroup});
  factory IncrementVarTest.fromJson(Map<String, dynamic> data) {
    final List<VarGroupLinker> tempList = [];
    if (data['varGroupList'] != null) {
      data['varGroupList'].forEach((linker) {
        tempList.add(VarGroupLinker.fromJson(linker));
      });
    }
    final smallestGroup = data['smallestGroup'] ?? 0.0;
    return IncrementVarTest(
        varGroupList: tempList, smallestGroup: smallestGroup);
  }
  Map<String, dynamic> toJson() => {
        "varGroupList": varGroupList == []
            ? null
            : List<dynamic>.from(varGroupList.map((x) => x.toJson())),
        "smallestGroup": smallestGroup
      };
  void addGroup(VarGroupLinker linker) {
    varGroupList.add(linker);
    findSmallestGroup();
  }

  void findSmallestGroup() {
    varGroupList.forEach((linker) {
      if (smallestGroup == 0.0) {
        best = linker;
      }
      if (linker.group.ctcGroupSize < best!.group.ctcGroupSize) {
        best = linker;
      }
    });
  }
}
