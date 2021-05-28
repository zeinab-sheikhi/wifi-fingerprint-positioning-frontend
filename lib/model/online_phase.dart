class OnlinePhaseModel {

  Map<String, int> accessPoints;
  int hour;
  int minute;

  OnlinePhaseModel(
  {
    required this.accessPoints,
    required this.hour,
    required this.minute,
  });

  Map toJson() => {
    'accessPoints': accessPoints,
    'hour': hour,
    'minute': minute,
  };
}