import 'access_point.dart';

class Point {

  final String pointCoordinate;
  final List<AccessPoint> accessPoints;

  Point(this.pointCoordinate, this.accessPoints);

  Map toJson() {

    return {
      'location': pointCoordinate,
      'signals_value': accessPoints
    };
  }
}

