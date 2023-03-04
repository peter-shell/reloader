import 'package:measure_group/classes/class_group.dart';
import 'package:measure_group/classes/class_shot.dart';
import 'package:test/test.dart';

void main() {
  List<Shot> myShots = [];
  double velocity = 2700.0;
  for (int i = 0; i < 6; i++) {
    myShots.add(Shot(velocity: velocity, xpos: 0, ypos: 0));
    velocity += 25;
  }
  Group mygroup = Group(
      shots: [],
      ctcGroupSize: 0,
      avgVelocity: 0,
      extremeSpread: 0,
      maxVelocity: 0,
      minVelocity: 0,
      standDeviation: 0);
  myShots.forEach((shot) => {
        mygroup.add(shot),
        // print("Average Velocity: ${mygroup.avgVelocity}"),
        // print("Standard Deviation: ${mygroup.standDeviation}"),
        // print("Extreme Spread ${mygroup.extremeSpread}"),
        // print("Max Velocity: ${mygroup.maxVelocity}"),
        // print("Min Velocity: ${mygroup.minVelocity}"),
      });
  test("All shot objects were added", () => {expect(mygroup.shots.length, 6)});
  test("first shot is correct speed",
      () => {expect(mygroup.shots[0].velocity, 2700.0)});
  test("test setting ctcSize",
      () => {mygroup.ctcGroupSize = .89, expect(mygroup.ctcGroupSize, .89)});
}
