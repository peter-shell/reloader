import 'package:collection/collection.dart';
import 'package:measure_group/classes/class_var_group_linker_test.dart';

class IncrementVarTest {
  List<VarGroupLinker> varGroupList = [];
  double smallestGroup;
  double largestGroup;
  double averageGroup;
  String testType;

  IncrementVarTest(
      {required this.varGroupList,
      required this.smallestGroup,
      required this.largestGroup,
      required this.averageGroup,
      required this.testType});
  factory IncrementVarTest.fromJson(Map<String, dynamic> data) {
    final List<VarGroupLinker> tempList = [];
    if (data['varGroupList'] != null) {
      data['varGroupList'].forEach((linker) {
        tempList.add(VarGroupLinker.fromJson(linker));
      });
    }
    final smallestGroup = data['smallestGroup'] ?? 0.0;
    final largestGroup = data['largestGroup'] ?? 0.0;
    final averageGroup = double.parse(data['averageGroup'] ?? 0.0);
    final testType = data['testType'] ?? "";
    return IncrementVarTest(
        varGroupList: tempList,
        smallestGroup: smallestGroup,
        largestGroup: largestGroup,
        averageGroup: averageGroup,
        testType: testType);
  }
  Map<String, dynamic> toJson() => {
        "varGroupList": varGroupList == []
            ? null
            : List<dynamic>.from(varGroupList.map((x) => x.toJson())),
        "smallestGroup": smallestGroup,
        "largestGroup": largestGroup,
        "averageGroup": averageGroup.toStringAsFixed(2),
        "testType": testType
      };
  void addGroup(VarGroupLinker linker) {
    varGroupList.add(linker);
    smallestAndLargestGroup();
  }

  double roundDouble(double doubleToRound, int spacesToRightOfDecimal) {
    String number = doubleToRound.toStringAsFixed(spacesToRightOfDecimal);
    return double.parse(number);
  }

  double calAverage(List<double> groupSizes) {
    return groupSizes.average;
  }

  void smallestAndLargestGroup() {
    List<double> groupSizes = [];

    for (int i = 0; i < varGroupList.length; i++) {
      groupSizes.add(varGroupList[i].group.ctcGroupSize);
      if (smallestGroup == 0.0) {
        smallestGroup = varGroupList[i].group.ctcGroupSize;

        //largestGroup = linker.group.ctcGroupSize;
      }
      // smallest group
      if (varGroupList[i].group.ctcGroupSize < smallestGroup) {
        smallestGroup = varGroupList[i].group.ctcGroupSize;
      }
      // largest
      if (varGroupList[i].group.ctcGroupSize > largestGroup) {
        largestGroup = varGroupList[i].group.ctcGroupSize;
      }
    }
    averageGroup = calAverage(groupSizes);
  }
}
