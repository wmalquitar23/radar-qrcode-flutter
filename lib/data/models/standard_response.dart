class StandardResponse {
  final String message;
  final dynamic data;
  final int code;

  StandardResponse({this.message, this.data, this.code});

  factory StandardResponse.fromJson(Map<String, dynamic> json) {
    try {
      return StandardResponse(
        message: json["message"],
        data: json["data"],
        code: json["code"],
      );
    } catch (e) {
      throw Exception("Http error.");
    }
  }
}
