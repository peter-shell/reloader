import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_shot.dart';
import 'package:test/test.dart';

void main() {
  List<Shot> myShots = [];
  double velocity = 2700.0;
  double xpos = 10;
  double ypos = 10;
  for (int i = 0; i < 5; i++) {
    myShots.add(Shot(velocity: velocity, xpos: xpos, ypos: ypos));
    velocity += 0;
    xpos += 10.5;
    ypos += 75.2;
  }
  Group mygroup = Group(
      shots: [],
      ctcGroupSize: 0,
      avgVelocity: 0,
      extremeSpread: 0,
      maxVelocity: 0,
      minVelocity: 0,
      standDeviation: 0);
  mygroup.bulletDiameter = .264;
  mygroup.iconSize = 50;
  myShots.forEach((shot) => {
        mygroup.addShot(shot),

        // print(
        //     "avg x pos: ${mygroup.returnAverageXPosOfShots(mygroup.returnLowestPointInGroup("x"))}"),
        //print(mygroup.ctcGroupSize.toString())
        // print("Average Velocity: ${mygroup.avgVelocity}"),
        // print("Standard Deviation: ${mygroup.standDeviation}"),
        // print("Extreme Spread ${mygroup.extremeSpread}"),
        // print("Max Velocity: ${mygroup.maxVelocity}"),
        // print("Min Velocity: ${mygroup.minVelocity}"),
      });
  test("All shot objects were added", () => {expect(mygroup.shots.length, 5)});
  test("first shot is correct speed",
      () => {expect(mygroup.shots[0].velocity, 2700.0)});
  test("test setting ctcSize",
      () => {mygroup.ctcGroupSize = .89, expect(mygroup.ctcGroupSize, .89)});
  test(
      "return center position of all xpos in group",
      () => {
            expect(
                mygroup.returnAverageXPosOfShots(
                    mygroup.returnLowestPointInGroup("x")),
                36.25)
          });
  //mygroup.calculateGroupMeanRadius();
  //print(mygroup.groupMeanRadius);
}
