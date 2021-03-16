import 'dart:convert';

import 'package:montesinaiweb/model/sucursal_response.dart';

import '../model/sucursal_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SucursalService with ChangeNotifier {
  List<SucursalModel> sucursalesR;
  Future<List<SucursalModel>> listar(String opcion, String proid) async {
    String url = "https://monte-sinai.herokuapp.com/sucursal/listar";
    String op = "opcion=" + opcion;
    String pid = "pro_id=" + proid;
    String urlFinal = url + "?" + op + "&" + pid;
    try {
      final response = await http.get(urlFinal);
      final sucursalResponse = sucursalListaResponseFromJson(response.body);

      Future.delayed(Duration.zero, () {
        this.sucursalesR = sucursalResponse.sucursales;
      });
      print('SUCURSALES: ' + response.body);
      notifyListeners();
      return sucursalResponse.sucursales;
    } on Error catch (e) {
      print("Error: $e");
    }
  }
}
