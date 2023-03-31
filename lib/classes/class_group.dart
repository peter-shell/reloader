import 'dart:io';
import 'dart:math';
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
      this.pathToImageOfGroup = ""});

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
        pathToImageOfGroup: pathToImageOfGroup);
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
        "pathToImageOfGroup": pathToImageOfGroup
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

  void calculateGroupSize() {
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
    double plusHalfBulletDiameter = distanceInInches;
    // TODO: unsure about adding half here. It seems close on the sample, need to do some testing on this soon!

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
      calculateGroupSize();
      // print(iconSize);
      // print(ctcGroupSize);
    }
  }

  void removeShotAtIndex0() {
    shots.removeAt(0);
    numShots -= 1;
    if (shots.length > 1) {
      calculateGroupSize();
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
}
