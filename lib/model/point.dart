import 'accesspoint.dart';

class Point {

  final int xCoordinate;
  final int yCoordinate;
  final List<AccessPoint> accessPoints;

  Point(this.xCoordinate, this.yCoordinate, this.accessPoints);

  Map toJson() {
    // List<Map> accessPoints =
    //   this.accessPoints != null ? this.accessPoints.map((i) => i.toJson()).toList() : null;

    return {
      'x': xCoordinate,
      'y': yCoordinate,
      'signals_value': accessPoints
    };
  }
}

