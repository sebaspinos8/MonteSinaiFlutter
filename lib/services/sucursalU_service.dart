import 'dart:convert';

import '../model/sucursal_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SucursalUService with ChangeNotifier {
  SucursalModel sucursalR;

  Future<SucursalModel> listar(String sucid) async {
    String url = "https://monte-sinai.herokuapp.com/sucursal/listarID";
    String sid = "suc_id=" + sucid;
    String urlFinal = url + "?" + sid;
    SucursalModel resp;
    try {
      final response = await http.get(urlFinal);
      resp = SucursalModel.fromJson(
        json.decode(response.body),
      );
      print(response.body);
      Future.delayed(Duration.zero, () {
        this.sucursalR = resp;
      });
      notifyListeners();
      return resp;
    } on Error catch (e) {
      print("Error: $e");
    }
  }
}
