class StandardResponse {
  final String message;
  final dynamic data;
  final int code;

  StandardResponse.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        data = json["data"],
        code = json["code"];
}
