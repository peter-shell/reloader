import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'class_shot.dart';

class Group {
  List<Shot> shots = [];
  double ctcGroupSize;
  double avgVelocity;
  double minVelocity;
  double maxVelocity;
  double standDeviation;
  double extremeSpread;
  int numShots;
  double bulletDiameter; // needs set by frontend
  double iconSize; // needs set by frontend
  String pathToImageOfGroup;
  Shot? centerOfGroup;
  double groupMeanRadius;
  Group(
      {required this.shots,
      required this.ctcGroupSize,
      required this.avgVelocity,
      required this.extremeSpread,
      required this.maxVelocity,
      required this.minVelocity,
      required this.standDeviation,
      this.numShots = 0,
      this.bulletDiameter = 0.0,
      this.iconSize = 0.0,
      this.pathToImageOfGroup = "",
      this.centerOfGroup,
      this.groupMeanRadius = 0});

  factory Group.fromJson(Map<String, dynamic> data) {
    final List<Shot> tempshots = [];
    if (data['shots'] != null) {
      data['shots'].forEach((shot) {
        tempshots.add(Shot.fromJson(shot));
      });
    }
    final ctcGroupSize = double.parse(data['ctcGroupSize'] ?? "0.0");
    final avgVelocity = double.parse(data['avgVelocity'] ?? "0.0");
    final minVelocity = double.parse(data['minVelocity'] ?? "0.0");
    final maxVelocity = double.parse(data['maxVelocity'] ?? "0.0");
    final standDeviation = double.parse(data['standDeviation'] ?? "0.0");
    final extremeSpread = double.parse(data['extremeSpread'] ?? "0.0");
    final numShots = int.parse(data['numShots'] ?? "0");
    final bulletDiameter = double.parse(data['bulletDiameter']);
    final iconSize = double.parse(data['iconSize']);
    final pathToImageOfGroup = data['pathToImageOfGroup'];
    final centerOfGroup = data['centerOfGroup'];
    final groupMeanRadius = data['groupMeanRadius'];
    return Group(
        shots: tempshots,
        ctcGroupSize: ctcGroupSize,
        avgVelocity: avgVelocity,
        minVelocity: minVelocity,
        maxVelocity: maxVelocity,
        standDeviation: standDeviation,
        extremeSpread: extremeSpread,
        numShots: numShots,
        bulletDiameter: bulletDiameter,
        iconSize: iconSize,
        pathToImageOfGroup: pathToImageOfGroup,
        centerOfGroup: centerOfGroup,
        groupMeanRadius: groupMeanRadius);
  }
  Map<String, dynamic> toJson() => {
        "shots": shots == []
            ? null
            : List<dynamic>.from(shots.map((x) => x.toJson())),
        "ctcGroupSize": ctcGroupSize.toStringAsFixed(2),
        "avgVelocity": avgVelocity.toStringAsFixed(2),
        "minVelocity": minVelocity.toStringAsFixed(2),
        "maxVelocity": maxVelocity.toStringAsFixed(2),
        "standDeviation": standDeviation.toStringAsFixed(2),
        "extremeSpread": extremeSpread.toStringAsFixed(2),
        "numShots": numShots.toString(),
        "bulletDiameter": bulletDiameter.toStringAsFixed(3),
        "iconSize": iconSize.toStringAsFixed(2),
        "pathToImageOfGroup": pathToImageOfGroup,
        "centerOfGroup": centerOfGroup,
        "groupMeanRadius": groupMeanRadius
      };

  void calculateVelocityStuff() {
    double count = 0.0;
    double velocitySum = 0.0;
    double meanSum = 0.0;
    List velocityList = [];
    List meanSquaredList = [];

    if (shots.isNotEmpty) {
      shots.forEach((shot) {
        if (shot.velocity > 0.0) {
          // below comparison is needed as min velocity initialized at 0
          if (count == 0.0) {
            minVelocity = shot.velocity;
          }
          velocitySum += shot.velocity;
          count += 1.0;
          avgVelocity = velocitySum / count;

          if (shot.velocity < minVelocity) {
            minVelocity = shot.velocity;
          }
          if (shot.velocity > maxVelocity) {
            maxVelocity = shot.velocity;
          }
          velocityList.add(shot.velocity);
        }
      });
    }
    // calculate standard deviation
    if (velocityList.length > 1) {
      velocityList.forEach((velocity) {
        double squareMe = (velocity - avgVelocity);
        meanSquaredList.add(squareMe * squareMe);
      });
      meanSquaredList.forEach((velocitySquared) {
        meanSum += velocitySquared;
      });
      double squareRootMe = meanSum / meanSquaredList.length.toDouble();
      standDeviation = sqrt(squareRootMe);
      // calculate extreme spread
      extremeSpread = maxVelocity - minVelocity;
    }
  }

  void calculateGroupMeanRadius() {
    // mean radius (litz recommends)
    // find the mathematical center of the group you shot. Then you measure the distance of
    //each individual shot from the mathematical center and average those distances together.
    //to obtain the mean radius of a shot-group, measure the heights of all shots above the
    //lowest shot in the group. Average these measurements. The result is the height of the
    //center of the group above the lowest shot. Then in the same way, get the horizontal
    //distance of the center from the shot farthest to the left. These two measurements will
    //locate the group center. Now measure the distance of each shot from this center.
    //The average of these measures is the mean radius.

    double centerOfX = returnAverageXPosOfShots(returnLowestPointInGroup("x"));
    double centerOfY = returnAverageYposOfShots(returnLowestPointInGroup("y"));
    centerOfGroup = Shot(velocity: 0, xpos: centerOfX, ypos: centerOfY);
    List<double> shotDistancesFromCenter = [];
    for (int i = 0; i < shots.length; i++) {
      shotDistancesFromCenter
          .add(distanceBetweenTwoPoints(centerOfGroup!, shots[i]));
    }
    //print(shotDistancesFromCenter);
    double averageShotDistanceFromCenter = shotDistancesFromCenter.average;
    //print(averageShotDistanceFromCenter);
    // convert to inches, round up, and return
    double meanRadius = convertPixelsToInches(
        averageShotDistanceFromCenter, bulletDiameter, iconSize);
    //print(meanRadius);
    groupMeanRadius = double.parse(meanRadius.toStringAsFixed(3));
  }

  double returnAverageXPosOfShots(int indexOfLowestPosition) {
    // measure heights of all shots above the lowest, then average those measurements
    // subtract lowest from every shot, add up, average
    // then add the average back to the lowest shot for center position
    double averageHeight = 0;
    double lowestPosition = shots[indexOfLowestPosition].xpos;
    for (int i = 0; i < shots.length; i++) {
      if (i == indexOfLowestPosition) {
        continue;
      }
      averageHeight += shots[i].xpos - lowestPosition;
    }
    double averageXposition = (averageHeight / (shots.length - 1)) +
        shots[indexOfLowestPosition].xpos;
    return double.parse(averageXposition.toStringAsFixed(3));
  }

  double returnAverageYposOfShots(int indexOfLowestPosition) {
    //same as above
    double averageHeight = 0;
    double lowestPosition = shots[indexOfLowestPosition].ypos;
    for (int i = 0; i < shots.length; i++) {
      if (i == indexOfLowestPosition) {
        continue;
      }
      averageHeight += shots[i].ypos - lowestPosition;
    }
    double averageYposition = (averageHeight / (shots.length - 1)) +
        shots[indexOfLowestPosition].ypos;
    return double.parse(averageYposition.toStringAsFixed(3));
  }

  // "x" returns index of lowest xpos, "y" returns index of lowest ypos
  int returnLowestPointInGroup(String coordinatePlane) {
    switch (coordinatePlane) {
      case "x":
        // find the lowest shot
        int lowestPoint = 0;
        // set first shot as lowest, compare to the rest
        for (int i = 1; i < shots.length; i++) {
          if (shots[i].xpos < shots[lowestPoint].xpos) {
            lowestPoint = i;
          }
        }
        return lowestPoint;
      case "y":
        int lowestPoint = 0;
        for (int i = 1; i < shots.length; i++) {
          if (shots[i].ypos < shots[lowestPoint].ypos) {
            lowestPoint = i;
          }
        }
        return lowestPoint;
      default:
        throw "returnLowestPointInGroup: misused function parameter";
    }
  }

  void calculateGroupExtremeSpread() {
    // the parameter bulletDiameter is probably just temporary
    double greatestDistance = 0;
    for (int i = 0; i < shots.length; i++) {
      for (int k = 1; k < shots.length; k++) {
        if (distanceBetweenTwoPoints(shots[i], shots[k]) > greatestDistance) {
          greatestDistance = distanceBetweenTwoPoints(shots[i], shots[k]);
        }
      }
    }
    double distanceInInches =
        convertPixelsToInches(greatestDistance, bulletDiameter, iconSize);
    // do some rounding on distanceInInches

    ctcGroupSize = double.parse(distanceInInches.toStringAsFixed(3));
  }

  double distanceBetweenTwoPoints(Shot point1, Shot point2) {
    // sqrt ((p2x - p1x)^2 + (p2y - p1y)^2)
    num a = pow(point2.xpos - point1.xpos, 2);
    num b = pow(point2.ypos - point1.ypos, 2);
    return sqrt(a + b);
  }

  double convertPixelsToInches(double distanceInPixels, double knownMeasure,
      double pixelsOfKnownMeasure) {
    // divide  1  by knownMeasure, then multiple by pixelsOfKnownMeassure for pixels per inch
    // divide distanceInPixels by pixels per inch
    double pixelsPerInch = (1 / knownMeasure) * pixelsOfKnownMeasure;
    return distanceInPixels / pixelsPerInch;
  }

  void addShot(Shot shot) {
    shots.add(shot);
    if (shot.velocity > 1) {
      calculateVelocityStuff();
    }
    if (shots.length == 1) {
      ctcGroupSize = bulletDiameter;
    }
    numShots += 1;
    if (shots.length > 1) {
      calculateGroupExtremeSpread();
      // print(iconSize);
      // print(ctcGroupSize);
    }
  }

  void removeShotAtIndex0() {
    shots.removeAt(0);
    numShots -= 1;
    if (shots.length > 1) {
      calculateGroupExtremeSpread();
    }
    if (shots.length == 1) {
      ctcGroupSize = bulletDiameter;
    }
    if (shots.isEmpty) {
      ctcGroupSize = 0;
    }
  }

  File? returnImageOfGroup() {
    // could potentially add some error control stuff here; IE: what if no path?
    // probably better to handle that ourside the DRO
    if (pathToImageOfGroup != "") {
      return File(pathToImageOfGroup);
    }
  }

  //TODO: add vertical and horizontal standard deviation

  //TODO: add circular error probable
}
