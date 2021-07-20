class APIResult {
  int code;
  String error;
  bool succeed;
  dynamic data;

  APIResult(
      {this.code = 200, this.data, this.succeed = false, this.error = ''});

  bool noInternet() {
    return code == -1;
  }

  bool isSuccessful() {
    return succeed;
  }

  bool isFailed() {
    return !succeed;
  }
}