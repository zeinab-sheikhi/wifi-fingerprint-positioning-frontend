import 'access_point.dart';

class Point {

  final int xCoordinate;
  final int yCoordinate;
  final List<AccessPoint> accessPoints;

  Point(this.xCoordinate, this.yCoordinate, this.accessPoints);

  Map toJson() {

    return {
      'x': xCoordinate,
      'y': yCoordinate,
      'signals_value': accessPoints
    };
  }
}

