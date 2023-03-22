import 'package:measure_group/classes/class_test.dart';
import 'package:measure_group/classes/class_var_group_linker_test.dart';
import 'package:collection/collection.dart';

class IncrementVarTest extends GeneralTest {
  List<VarGroupLinker> varGroupList = [];
  double smallestGroup;
  double largestGroup;
  double averageGroup;

  IncrementVarTest(
      {required this.varGroupList,
      required this.smallestGroup,
      required this.largestGroup,
      required this.averageGroup});
  factory IncrementVarTest.fromJson(Map<String, dynamic> data) {
    final List<VarGroupLinker> tempList = [];
    if (data['varGroupList'] != null) {
      data['varGroupList'].forEach((linker) {
        tempList.add(VarGroupLinker.fromJson(linker));
      });
    }
    final smallestGroup = data['smallestGroup'] ?? 0.0;
    final largestGroup = data['largestGroup'] ?? 0.0;
    final averageGroup = data['averageGroup'] ?? 0.0;
    return IncrementVarTest(
        varGroupList: tempList,
        smallestGroup: smallestGroup,
        largestGroup: largestGroup,
        averageGroup: averageGroup);
  }
  Map<String, dynamic> toJson() => {
        "varGroupList": varGroupList == []
            ? null
            : List<dynamic>.from(varGroupList.map((x) => x.toJson())),
        "smallestGroup": smallestGroup,
        "largestGroup": largestGroup,
        "averageGroup": averageGroup
      };
  void addGroup(VarGroupLinker linker) {
    varGroupList.add(linker);
    smallestAndLargestGroup();
  }

  double calAverage(List<double> groupSizes) {
    double sum = 0;
    groupSizes.map((e) => sum += e);
    return sum / groupSizes.length;
  }

  void smallestAndLargestGroup() {
    List<double> groupSizes = [];

    varGroupList.map((linker) {
      groupSizes.add(linker.group.ctcGroupSize);
      if (smallestGroup == 0.0) {
        smallestGroup = linker.group.ctcGroupSize;

        //largestGroup = linker.group.ctcGroupSize;
      }
      // smallest group
      if (linker.group.ctcGroupSize < smallestGroup) {
        smallestGroup = linker.group.ctcGroupSize;
      }
      // largest
      if (linker.group.ctcGroupSize > largestGroup) {
        largestGroup = linker.group.ctcGroupSize;
      }
    });
    averageGroup = calAverage(groupSizes);
  }
}
