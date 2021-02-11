class AccessPoint {

  final String SSID;
  final int RSSI;

  AccessPoint(this.SSID, this.RSSI);

  Map toJson() => {
    'ssid': SSID,
    'rssi': RSSI,
  };

}