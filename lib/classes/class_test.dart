import 'package:measure_group/classes/class_var_group_linker_test.dart';

class GeneralTest {
  VarGroupLinker? best;
  VarGroupLinker? average;
  VarGroupLinker? worst;
  String testType;
  List<VarGroupLinker>? chargesAndGroups = [];
  GeneralTest(
      [this.best,
      this.average,
      this.worst,
      this.testType = "",
      this.chargesAndGroups]);

  factory GeneralTest.fromJson(Map<String, dynamic> data) {
    final List<VarGroupLinker> tempChargesAndGroups = [];
    if (data['chargesAndGroups'] != null) {
      data['chargesAndGroups'].forEach((shot) {
        tempChargesAndGroups.add(VarGroupLinker.fromJson(shot));
      });
    }
    final best = VarGroupLinker.fromJson(data['best']);
    final average = VarGroupLinker.fromJson(data['average']);
    final worst = VarGroupLinker.fromJson(data['worst']);
    final testType = data['testType'];
    return GeneralTest(best, average, worst, testType, tempChargesAndGroups);
  }
  Map<String, dynamic> toJson() => {
        "chargesAndGroups": chargesAndGroups == []
            ? null
            : List<dynamic>.from(chargesAndGroups!.map((x) => x.toJson())),
        "best": best!.toJson(),
        "average": average!.toJson(),
        "worst": worst!.toJson(),
        "testType": testType
      };
  void addChargeWeightAndGroup(VarGroupLinker cwAndGrp) {
    // TODO: add logic here to populate the test
    chargesAndGroups!.add(cwAndGrp);
  }
}
