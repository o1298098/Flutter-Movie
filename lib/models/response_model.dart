class ResponseModel<T> {
  final int statusCode;
  final String message;
  final T result;
  ResponseModel({this.message, this.result, this.statusCode});
  bool get success => [200, 201].contains(statusCode);
}
