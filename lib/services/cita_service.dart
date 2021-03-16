import 'dart:convert';

import 'package:montesinaiweb/model/cita_model.dart';
import 'package:montesinaiweb/model/cita_response.dart';

import '../model/login_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CitaService with ChangeNotifier {
  List<CitaModel> citasR;

  Future<String> agregarCita(String cit, String fecha, String hora,
      String asunto, String pac, String suc, String pro) async {
    String url = "https://monte-sinai.herokuapp.com/cita/agr_mod";
    String citid = "cit_id=" + cit;
    String fecha1 = "fecha=" + fecha;
    String hora1 = "hora=" + hora;
    String asunto1 = "asunto=" + asunto;
    String proid = "pro_id=" + pro;
    String pacid = "pac_id=" + pac;
    String sucid = "suc_id=" + suc;
    String urlFinal = url +
        "?" +
        citid +
        "&" +
        fecha1 +
        "&" +
        hora1 +
        "&" +
        asunto1 +
        "&" +
        proid +
        "&" +
        pacid +
        "&" +
        sucid;

    try {
      print(urlFinal);
      final response = await http.post(urlFinal);
      var res =
          (response.body.contains("ingresado") ? "ingresar" : "modificar");
      return res;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<String> eliminarCita(String citid, String opcion) async {
    String url = "https://monte-sinai.herokuapp.com/cita/eliminar";
    String cit = "cit_id=" + citid;
    String op = "opcion=" + opcion;
    String urlFinal = url + "?" + cit + "&" + op;

    try {
      final response = await http.post(urlFinal);
      var res = (response.body.contains("alta") ? "alta" : "baja");
      return res;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<List<CitaModel>> listarCita(
      String opcion, String proid, String sucid) async {
    String url = "https://monte-sinai.herokuapp.com/cita/listar";
    String op = "opcion=" + opcion;
    String pid = "pro_id=" + proid;
    String sid = "suc_id=" + sucid;
    String urlFinal = url + "?" + op + "&" + pid + "&" + sid;
    try {
      final response = await http.get(urlFinal);
      final citaResponse = citaListaResponseFromJson(response.body);

      Future.delayed(Duration.zero, () {
        this.citasR = citaResponse.citas;
      });
      notifyListeners();
      return citaResponse.citas;
    } on Error catch (e) {
      print("Error: $e");
    }
  }
}
