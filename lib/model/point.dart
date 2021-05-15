import 'access_point.dart';

class Point {

  final int xCoordinate;
  final int yCoordinate;
  final int totalScanTime;
  final int intervalTime;
  final String dateTime;
  final List<AccessPoint> accessPoints;

  Point(
      this.xCoordinate,
      this.yCoordinate,
      this.totalScanTime,
      this.intervalTime,
      this.dateTime,
      this.accessPoints);

  Map toJson() {

    return {
      'x': xCoordinate,
      'y': yCoordinate,
      'totalScanTime': totalScanTime,
      'intervalTime': intervalTime,
      'dateTime': dateTime,
      'accessPoints': accessPoints
    };
  }
}

