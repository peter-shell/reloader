import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';
import 'package:measure_group/classes/class_shot.dart';
import 'package:measure_group/classes/class_var_group_linker_test.dart';
import 'package:test/test.dart';

void main() {
  IncrementVarTest myTest =
      IncrementVarTest(varGroupList: [], smallestGroup: 0.0);

  test('add one linker to mytest', () {
    Group firstGroup = Group(
        shots: [],
        ctcGroupSize: 1.5,
        avgVelocity: 0,
        extremeSpread: 0,
        maxVelocity: 0,
        minVelocity: 0,
        standDeviation: 0);
    firstGroup.add(Shot(velocity: 2715, xpos: 0, ypos: 0));
    firstGroup.add(Shot(velocity: 2710, xpos: 0, ypos: 0));
    firstGroup.add(Shot(velocity: 2716, xpos: 0, ypos: 0));
    myTest.add(VarGroupLinker(chargeWeight: 40.5, group: firstGroup));
    expect(myTest.varGroupList.length, 1);
  });

  test('add one more linker, check best group', () {
    Group secondGroup = Group(
        shots: [],
        ctcGroupSize: 0,
        avgVelocity: 0,
        extremeSpread: 0,
        maxVelocity: 0,
        minVelocity: 0,
        standDeviation: 0);
    secondGroup.add(Shot(velocity: 2715, xpos: 0, ypos: 0));
    secondGroup.add(Shot(velocity: 2780, xpos: 0, ypos: 0));
    secondGroup.add(Shot(velocity: 2755, xpos: 0, ypos: 0));
    secondGroup.ctcGroupSize = .4;
    myTest.add(VarGroupLinker(chargeWeight: 40.8, group: secondGroup));

    expect(myTest.best!.chargeWeight, 40.8);
    expect(myTest.best!.group.ctcGroupSize, .4);
  });
}
