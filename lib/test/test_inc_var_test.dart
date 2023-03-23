import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_inc_var_test.dart';
import 'package:measure_group/classes/class_shot.dart';
import 'package:measure_group/classes/class_var_group_linker_test.dart';
import 'package:test/test.dart';

void main() {
  IncrementVarTest myTest = IncrementVarTest(
      varGroupList: [],
      smallestGroup: 0.0,
      largestGroup: 0.0,
      averageGroup: 0.0,
      testType: "");
  Group firstGroup = Group(
      shots: [],
      ctcGroupSize: 1.5,
      avgVelocity: 0,
      extremeSpread: 0,
      maxVelocity: 0,
      minVelocity: 0,
      standDeviation: 0);
  firstGroup.addShot(Shot(velocity: 2715, xpos: 0, ypos: 0));
  firstGroup.addShot(Shot(velocity: 2710, xpos: 0, ypos: 0));
  firstGroup.addShot(Shot(velocity: 2716, xpos: 0, ypos: 0));

  Group secondGroup = Group(
      shots: [],
      ctcGroupSize: 0,
      avgVelocity: 0,
      extremeSpread: 0,
      maxVelocity: 0,
      minVelocity: 0,
      standDeviation: 0);
  secondGroup.addShot(Shot(velocity: 2715, xpos: 0, ypos: 0));
  secondGroup.addShot(Shot(velocity: 2780, xpos: 0, ypos: 0));
  secondGroup.addShot(Shot(velocity: 2755, xpos: 0, ypos: 0));
  secondGroup.ctcGroupSize = .4;
  print("Second group: ${secondGroup.ctcGroupSize}");
  myTest.addGroup(VarGroupLinker(chargeWeight: 40.5, group: firstGroup));
  myTest.addGroup(VarGroupLinker(chargeWeight: 40.8, group: secondGroup));

  test('add one linker to mytest', () {
    expect(myTest.varGroupList.length, 2);
  });

  // test('add one more linker, check best group', () {
  //   expect(myTest.best!.chargeWeight, 40.8);
  //   expect(myTest.best!.group.ctcGroupSize, .4);
  // });
  var testJson = myTest.toJson();
  //print(testJson);
  IncrementVarTest mySecondTest = IncrementVarTest.fromJson(testJson);

  test('compares og test to rebuild from json', () {
    expect(myTest.smallestGroup, mySecondTest.smallestGroup);
  });
  // print("first group: ${firstGroup.ctcGroupSize}");
  // print(myTest.varGroupList[0].group.ctcGroupSize);
  test("tests largest group function", () {
    expect(myTest.largestGroup, 1.5);
  });
  test("tests smallest group function", () {
    expect(myTest.smallestGroup, .4);
  });
  test("tests average group function", () {
    expect(myTest.averageGroup, .95);
  });
  test("checks length of myTest", () {
    expect(myTest.varGroupList.length, 2);
  });
}
