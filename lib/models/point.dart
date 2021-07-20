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
      'T': totalScanTime,
      'Ts': intervalTime,
      'dateTime': dateTime,
      'accessPoints': accessPoints
    };
  }
}
class AccessPoint {

  final String BSSID;
  final List<int> RSSIs;

  AccessPoint(this.BSSID, this.RSSIs);

  Map toJson() => {
    'BSSID': BSSID,
    'RSSIs': RSSIs,
  };

}

