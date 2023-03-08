import 'dart:math';

import 'class_shot.dart';

//TODO: add some built in checking for shots added to list;
// if that's the case, need to increment shot count

class Group {
  List<Shot> shots = [];
  double ctcGroupSize;
  double avgVelocity;
  double minVelocity;
  double maxVelocity;
  double standDeviation;
  double extremeSpread;
  double numShots;
  Group(
      {required this.shots,
      required this.ctcGroupSize,
      required this.avgVelocity,
      required this.extremeSpread,
      required this.maxVelocity,
      required this.minVelocity,
      required this.standDeviation,
      required this.numShots});
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
    final numShots = double.parse(data['numShots'] ?? "0.0");
    return Group(
        shots: tempshots,
        ctcGroupSize: ctcGroupSize,
        avgVelocity: avgVelocity,
        minVelocity: minVelocity,
        maxVelocity: maxVelocity,
        standDeviation: standDeviation,
        extremeSpread: extremeSpread,
        numShots: numShots);
  }
  Map<String, dynamic> toJson() => {
        "shots": shots == []
            ? null
            : List<dynamic>.from(shots.map((x) => x.toJson())),
        "ctcGroupSize": ctcGroupSize.toString(),
        "avgVelocity": avgVelocity.toString(),
        "minVelocity": minVelocity.toString(),
        "maxVelocity": maxVelocity.toString(),
        "standDeviation": standDeviation.toString(),
        "extremeSpread": extremeSpread.toString(),
        "numShots": numShots.toString()
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

  void add(Shot shot) {
    shots.add(shot);
    if (shot.velocity > 1) {
      calculateVelocityStuff();
    }
  }
}
