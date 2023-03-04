import 'package:measure_group/classes/class_group.dart';

class VarGroupLinker {
  double chargeWeight;
  Group group;
  VarGroupLinker({required this.chargeWeight, required this.group});
  factory VarGroupLinker.fromJson(Map<String, dynamic> data) {
    final chargeWeight = data['chargeWeight'];
    final group = data['group'];
    return VarGroupLinker(chargeWeight: chargeWeight, group: group);
  }
  Map<String, dynamic> toJson() =>
      {"chargeWeight": chargeWeight, "group": group.toJson()};
}
