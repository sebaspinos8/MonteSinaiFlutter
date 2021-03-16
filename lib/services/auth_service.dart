import 'dart:convert';

import '../model/login_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  LoginRequestModel loginR;

  Future<LoginRequestModel> login(String usuarioR, String pass) async {
    String url = "https://monte-sinai.herokuapp.com/auth/login";
    String usuario = "usuario=" + usuarioR;
    String password = "password=" + pass;
    String urlFinal = url + "?" + usuario + "&" + password;
    LoginRequestModel resp;
    try {
      final response = await http.get(urlFinal);

      if (response.statusCode == 200 || response.statusCode == 302) {
        if (response.body.contains("no existe")) {
          resp = LoginRequestModel.fromJson(
            json.decode('{"LOG_USUARIO": "NO EXISTE", "PRO_ID": -1}'),
          );
        } else if (response.body.contains("nuevamente")) {
          resp = LoginRequestModel.fromJson(
            json.decode('{"LOG_USUARIO": "NO EXISTE", "PRO_ID": 0}'),
          );
        } else {
          resp = LoginRequestModel.fromJson(
            json.decode(response.body),
          );
        }
      }
      Future.delayed(Duration.zero, () {
        this.loginR = resp;
      });

      notifyListeners();

      return resp;
    } on Error catch (e) {
      print("Error: $e");
    }
  }
}
