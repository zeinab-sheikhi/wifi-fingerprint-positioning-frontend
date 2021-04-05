class AccessPoint {

  final String SSID;
  final List<dynamic> RSSIs;

  AccessPoint(this.SSID, this.RSSIs);

  Map toJson() => {
  'SSID': SSID,
  'RSSIs': RSSIs
  };

}