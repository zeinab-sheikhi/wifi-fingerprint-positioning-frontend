class AccessPoint {

  final String BSSID;
  final int averageRSSI;

  AccessPoint(this.BSSID, this.averageRSSI);

  Map toJson() => {
  'BSSID': BSSID,
  'averageRSSI': averageRSSI
  };

}