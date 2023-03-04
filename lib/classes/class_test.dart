import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_var_group_linker_test.dart';

class GeneralTest {
  VarGroupLinker? best;
  VarGroupLinker? average;
  VarGroupLinker? worst;
  GeneralTest([this.best, this.average, this.worst]);

  factory GeneralTest.fromJson(Map<String, dynamic> data) {
    final best = VarGroupLinker.fromJson(data['best']);
    final average = VarGroupLinker.fromJson(data['average']);
    final worst = VarGroupLinker.fromJson(data['worst']);
    return GeneralTest(best, average, worst);
  }
  Map<String, dynamic> toJson() => {
        "best": best!.toJson(),
        "average": average!.toJson(),
        "worst": worst!.toJson()
      };
}
