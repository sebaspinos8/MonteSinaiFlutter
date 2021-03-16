import 'dart:convert';

LoginRequestModel loginResponseFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginResponseToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({this.usuario, this.proid});

  String usuario;
  int proid;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        usuario: json["LOG_USUARIO"],
        proid: json["PRO_ID"],
      );

  Map<String, dynamic> toJson() => {
        "LOG_USUARIO": usuario,
        "PRO_ID": proid,
      };
}
