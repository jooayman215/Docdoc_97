class AuthResponse {
  String? message;
  Data? data;
  bool? status;
  int? code;

  AuthResponse({this.message, this.data, this.status, this.code});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    code = json['code'];
  }
}

class Data {
  String? token;
  String? username;

  Data({this.token, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
  }
}
