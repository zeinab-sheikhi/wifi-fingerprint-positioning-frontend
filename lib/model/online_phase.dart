class OnlinePhaseModel {

  Map<String, int> accessPoints;
  String classificationModel;
  String regressionModel;

  OnlinePhaseModel(
  {
    required this.accessPoints,
    required this.classificationModel,
    required this.regressionModel,
  });

  Map toJson() => {
    'accessPoints': accessPoints,
    'classification': classificationModel,
    'regression': regressionModel,
  };
}