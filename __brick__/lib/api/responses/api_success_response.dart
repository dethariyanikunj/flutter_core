class ApiSuccessResponse {
  int? code;
  bool? success;
  String? message;

  ApiSuccessResponse({
    this.code,
    this.success,
    this.message,
  });

  ApiSuccessResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
