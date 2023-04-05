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
  double standardDeviationX;
  double standardDeviationY;
  double radialStandardDeviaiton;
  double rangeInYards;
  double moaExtremeSpread;
  double moaMeanRadius;
  double moaSDx;
  double moaSDy;
  double moaSDr;
  double circleErrorProbable;
  double moaCep;
  double xHeight;
  double moaXheight;
  double yHeight;
  double moaYheight;

  Group({
    required this.shots,
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
    this.groupMeanRadius = 0,
    this.standardDeviationX = 0,
    this.standardDeviationY = 0,
    this.radialStandardDeviaiton = 0,
    this.rangeInYards = 0,
    this.moaExtremeSpread = 0,
    this.moaMeanRadius = 0,
    this.moaSDx = 0,
    this.moaSDy = 0,
    this.moaSDr = 0,
    this.circleErrorProbable = 0,
    this.moaCep = 0,
    this.xHeight = 0,
    this.moaXheight = 0,
    this.yHeight = 0,
    this.moaYheight = 0,
  });

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
    final standardDeviationX = data['standardDeviationX'];
    final standardDeviationY = data['standardDeviationY'];
    final radialStandardDeviaiton = data['radialStandardDeviaiton'];
    final rangeInYards = data['rangeInYards'];
    final moaExtremeSpread = data['moaExtremeSpread'];
    final moaMeanRadius = data['moaMeanRadius'];
    final moaSDx = data['moaSDx'];
    final moaSDy = data['moaSDy'];
    final moaSDr = data['moaSDr'];
    final circleErrorProbable = data['circleErrorProbable'];
    final moaCep = data['moaCep'];
    final xHeight = data['xHeight'];
    final moaXheight = data['moaXheight'];
    final yHeight = data['yHeight'];
    final moaYheight = data['moaYheight'];

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
      groupMeanRadius: groupMeanRadius,
      standardDeviationX: standardDeviationX,
      standardDeviationY: standardDeviationY,
      radialStandardDeviaiton: radialStandardDeviaiton,
      rangeInYards: rangeInYards,
      moaExtremeSpread: moaExtremeSpread,
      moaMeanRadius: moaMeanRadius,
      moaSDx: moaSDx,
      moaSDy: moaSDy,
      moaSDr: moaSDr,
      circleErrorProbable: circleErrorProbable,
      moaCep: moaCep,
      xHeight: xHeight,
      moaXheight: moaXheight,
      yHeight: yHeight,
      moaYheight: moaYheight,
    );
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
        "groupMeanRadius": groupMeanRadius,
        "standardDeviationX": standardDeviationX,
        "standardDeviationY": standardDeviationY,
        "radialStandardDeviaiton": radialStandardDeviaiton,
        "rangeInYards": rangeInYards,
        "moaExtremeSpread": moaExtremeSpread,
        "moaMeanRadius": moaMeanRadius,
        "moaSDx": moaSDx,
        "moaSDy": moaSDy,
        "moaSDr": moaSDr,
        "circleErrorProbable": circleErrorProbable,
        "moaCep": moaCep,
        "xHeight": xHeight,
        "moaXheight": moaXheight,
        "yHeight": yHeight,
        "moaYheight": moaYheight,
      };

  void calculateVelocityStuff() {
    double count = 0.0;
    double velocitySum = 0.0;
    List<double> velocityList = [];

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
      standDeviation = returnStandardDeviation(velocityList);

      // calculate extreme spread
      extremeSpread = maxVelocity - minVelocity;
    }
  }

  // returns "height" of y coordinate plane group in inches, precision of 3
  double returnFurthestPointInY() {
    double lowestPoint = shots[returnLowestPointInGroup("y")].ypos;
    double highestPoint = shots[getHeightY()].ypos;
    return getDistanceInInches(lowestPoint, highestPoint);
  }

  // returns "height" of x coordinate plane group in inches, precision of 3
  double returnFurthestPointInX() {
    double lowestPoint = shots[returnLowestPointInGroup("x")].xpos;
    double highestPoint = shots[getHeightInX()].xpos;
    return getDistanceInInches(lowestPoint, highestPoint);
  }

  //helper function for returnFurthestPointInY and returnFurthestPointInX
  // returns furthest point, independant of plane, that's in inches and rounded
  double getDistanceInInches(double startPoint, double endPoint) {
    double distanceInPixels = endPoint - startPoint;

    return convertPixelsToInches(distanceInPixels, bulletDiameter, iconSize);
  }

  // helper for returnFurthestPointInY
  // returns index of shot.obj with furthest point in Y coordinate plane
  int getHeightY() {
    int highestPoint = 0;

    for (int i = 1; i < shots.length; i++) {
      if (shots[i].ypos > shots[highestPoint].ypos) {
        highestPoint = i;
      }
    }
    return highestPoint;
  }

  // helper function for returnFurthestPointInX
  // returns index of shot.obj with furthest point in X coordinate plane
  int getHeightInX() {
    int highestPoint = 0;

    for (int i = 1; i < shots.length; i++) {
      if (shots[i].xpos > shots[highestPoint].xpos) {
        highestPoint = i;
      }
    }
    return highestPoint;
  }

  double retunCircleErrorProbable() {
    double standardDeviation = calculateRadialStandardDeviation();
    double cep = standardDeviation * 0.59;
    return double.parse(cep.toStringAsFixed(3));
  }

  double returnMOA(double distancInYards, double groupSizeInInches) {
    // calculate how large an MOA is at the given distance,
    //(range in yards/100 yards) x 1.047 MOA.
    //Then divide the size of the group in inches by this value.
    double moaAtDistance = (distancInYards / 100) * 1.047;
    double moa = groupSizeInInches / moaAtDistance;
    return double.parse(moa.toStringAsFixed(3));
  }

  double calculateStandardDeviationOfX() {
    List<double> linearNumbers = [];
    for (int i = 0; i < shots.length; i++) {
      linearNumbers.add(shots[i].xpos);
    }
    double standardDeviation = returnStandardDeviation(linearNumbers);
    return convertPixelsToInches(standardDeviation, bulletDiameter, iconSize);
  }

  double calculateStandardDeviationOfY() {
    List<double> linearNumbers = [];
    for (int i = 0; i < shots.length; i++) {
      linearNumbers.add(shots[i].ypos);
    }
    double standardDeviation = returnStandardDeviation(linearNumbers);
    return convertPixelsToInches(standardDeviation, bulletDiameter, iconSize);
  }

  double calculateRadialStandardDeviation() {
    if (centerOfGroup != null && shots.length > 1) {
      setCenterOfGroup();
    }
    List<double> distanceFromCenter = getDistancesFromCenter();
    double radialStandardDeviation =
        returnStandardDeviation(distanceFromCenter);
    double rsdInInches = convertPixelsToInches(
        radialStandardDeviation, bulletDiameter, iconSize);

    return rsdInInches;
  }

  // need more than one number in list
  double returnStandardDeviation(List<double> datasetForSDcal) {
    // σ_r = √[(1/n) * Σ(r_i - r_avg)^2]
    double averageDistanceFromCenter = datasetForSDcal.average;
    double multipleBy = 1 / datasetForSDcal.length;
    double sumOf = 0;
    double squareMe = 0;
    datasetForSDcal.forEach((number) {
      squareMe = number - averageDistanceFromCenter;
      sumOf += squareMe * squareMe;
      squareMe = 0; // yes I know...
    });
    double almostThere = multipleBy * sumOf;
    double radialStandardDeviation = sqrt(almostThere);
    return double.parse(radialStandardDeviation.toStringAsFixed(3));
  }

  void setCenterOfGroup() {
    double centerOfX = returnAverageXPosOfShots(returnLowestPointInGroup("x"));
    double centerOfY = returnAverageYposOfShots(returnLowestPointInGroup("y"));
    centerOfGroup = Shot(velocity: 0, xpos: centerOfX, ypos: centerOfY);
  }

  List<double> getDistancesFromCenter() {
    List<double> shotDistancesFromCenter = [];
    for (int i = 0; i < shots.length; i++) {
      shotDistancesFromCenter
          .add(distanceBetweenTwoPoints(centerOfGroup!, shots[i]));
    }
    return shotDistancesFromCenter;
  }

  double returnGroupMeanRadius() {
    // mean radius (litz recommends)
    // find the mathematical center of the group you shot. Then you measure the distance of
    //each individual shot from the mathematical center and average those distances together.
    //to obtain the mean radius of a shot-group, measure the heights of all shots above the
    //lowest shot in the group. Average these measurements. The result is the height of the
    //center of the group above the lowest shot. Then in the same way, get the horizontal
    //distance of the center from the shot farthest to the left. These two measurements will
    //locate the group center. Now measure the distance of each shot from this center.
    //The average of these measures is the mean radius.
    setCenterOfGroup();

    List<double> shotDistancesFromCenter = getDistancesFromCenter();
    //print(shotDistancesFromCenter);
    double averageShotDistanceFromCenter = shotDistancesFromCenter.average;
    //print(averageShotDistanceFromCenter);
    // convert to inches, round up, and return
    double meanRadius = convertPixelsToInches(
        averageShotDistanceFromCenter, bulletDiameter, iconSize);
    //print(meanRadius);
    return double.parse(meanRadius.toStringAsFixed(3));
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

  double calculateGroupExtremeSpread() {
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

    return distanceInInches;
  }

  double distanceBetweenTwoPoints(Shot point1, Shot point2) {
    // sqrt ((p2x - p1x)^2 + (p2y - p1y)^2)
    num a = pow(point2.xpos - point1.xpos, 2);
    num b = pow(point2.ypos - point1.ypos, 2);
    return sqrt(a + b);
  }

  // rounds to the third decimal place
  double convertPixelsToInches(double distanceInPixels, double knownMeasure,
      double pixelsOfKnownMeasure) {
    // divide  1  by knownMeasure, then multiple by pixelsOfKnownMeassure for pixels per inch
    // divide distanceInPixels by pixels per inch
    double pixelsPerInch = (1 / knownMeasure) * pixelsOfKnownMeasure;
    double finalFigure = distanceInPixels / pixelsPerInch;
    return double.parse(finalFigure.toStringAsFixed(3));
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
    // where the action happens.
    if (shots.length > 1) {
      ctcGroupSize = calculateGroupExtremeSpread();
      moaExtremeSpread = returnMOA(rangeInYards, extremeSpread);

      groupMeanRadius = returnGroupMeanRadius();
      moaMeanRadius = returnMOA(rangeInYards, groupMeanRadius);

      standardDeviationX = calculateStandardDeviationOfX();
      moaSDx = returnMOA(rangeInYards, standardDeviationX);

      standardDeviationY = calculateStandardDeviationOfY();
      moaSDy = returnMOA(rangeInYards, standardDeviationY);

      radialStandardDeviaiton = calculateRadialStandardDeviation();
      moaSDr = returnMOA(rangeInYards, radialStandardDeviaiton);

      circleErrorProbable = retunCircleErrorProbable();
      moaCep = returnMOA(rangeInYards, circleErrorProbable);

      xHeight = returnFurthestPointInX();
      moaXheight = returnMOA(rangeInYards, xHeight);

      yHeight = returnFurthestPointInY();
      moaYheight = returnMOA(rangeInYards, yHeight);
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

  // ballistic-x overlays look like:
  // distance/# shot group
  // extreme spread in/moa
  //TODO: width/height in

  // ATZ: mils
  // mean radius in/moa
  // windage in/moa
  // elevation in/moa
  // circular error probable
  // radial standard deviation
  // vertical standard deviation
  // horizontal standard deviaiton
}
