class AccessPoint {

  final String SSID;
  final List<int> rssiValues;

  AccessPoint(this.SSID, this.rssiValues);

  Map toJson() => {
  'ssid': SSID,
  'rssi': rssiValues
  };

}