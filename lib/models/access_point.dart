class AccessPoint {

  final String BSSID;
  final List<int> RSSIs;

  AccessPoint(this.BSSID, this.RSSIs);

  Map toJson() => {
  'BSSID': BSSID,
  'RSSIs': RSSIs,
  };

}