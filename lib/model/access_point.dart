class AccessPoint {

  final String BSSID;
  final int RSSI_avg;
  final int RSSI_size;
  final int RSSI_min;
  final int RSSI_max;
  final double RSSI_deviation;

  AccessPoint(
      this.BSSID,
      this.RSSI_avg,
      this.RSSI_size,
      this.RSSI_min,
      this.RSSI_max,
      this.RSSI_deviation);

  Map toJson() => {
  'BSSID': BSSID,
  'RSSI_avg': RSSI_avg,
  'RSSI_size': RSSI_size,
  'RSSI_min': RSSI_min,
  'RSSI_max': RSSI_max,
  'RSSI_deviation': RSSI_deviation
  };

}