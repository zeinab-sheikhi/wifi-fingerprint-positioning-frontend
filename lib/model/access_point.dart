class AccessPoint {

  final String BSSID;
  final int RSSI;
  // final List<dynamic> RSSIs;

  AccessPoint(this.BSSID, this.RSSI);

  Map toJson() => {
  'BSSID': BSSID,
  'RSSI': RSSI
  };

}