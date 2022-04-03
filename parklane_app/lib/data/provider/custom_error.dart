class CustomError implements Exception {
  final dynamic message;

  CustomError(this.message);
  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "$message";
  }
}
