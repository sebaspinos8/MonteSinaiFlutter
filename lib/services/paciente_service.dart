import 'dart:convert';

import 'package:montesinaiweb/model/paciente_model.dart';
import 'package:montesinaiweb/model/paciente_response.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PacienteService with ChangeNotifier {
  PacienteModel pacienteR;

  Future<String> agregarPaciente(
      String per,
      String nombre,
      String ident,
      String mail,
      String fechanac,
      String direccion,
      String telefono,
      String suc,
      String pro) async {
    String url = "https://monte-sinai.herokuapp.com/paciente/agr_mod";
    String perid = "per_id=" + per;
    String nom = "nombre=" + nombre;
    String iden = "ident=" + ident;
    String email = "mail=" + mail;
    String fecha = "fecha_nacimiento=" + fechanac;
    String dir = "direccion=" + direccion;
    String telf = "telefono=" + telefono;
    String sucid = "suc_id=" + suc;
    String proid = "pro_id=" + pro;
    String urlFinal = url +
        "?" +
        perid +
        "&" +
        nom +
        "&" +
        iden +
        "&" +
        email +
        "&" +
        fecha +
        "&" +
        dir +
        "&" +
        telf +
        "&" +
        sucid +
        "&" +
        proid;

    try {
      final response = await http.post(urlFinal);
      var res =
          (response.body.contains("ingresado") ? "ingresar" : "modificar");
      return res;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<List<PacienteModel>> listarPaciente(
      String opcion, String proid, String sucid) async {
    String url = "https://monte-sinai.herokuapp.com/paciente/listar";
    String op = "opcion=" + opcion;
    String pid = "pro_id=" + proid;
    String sid = "suc_id=" + sucid;
    String urlFinal = url + "?" + op + "&" + pid + "&" + sid;
    try {
      final response = await http.get(urlFinal);
      final pacienteResponse = pacienteListaResponseFromJson(response.body);

      return pacienteResponse.pacientes;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<PacienteModel> consultaPaciente(String proid, String pacid) async {
    String url = "https://monte-sinai.herokuapp.com/paciente/consulta";
    String pid = "pro_id=" + proid;
    String paid = "pac_id=" + pacid;
    String urlFinal = url + "?" + paid + "&" + pid;
    PacienteModel resp;
    try {
      final response = await http.get(urlFinal);
      resp = PacienteModel.fromJson(
        json.decode(response.body),
      );
      Future.delayed(Duration.zero, () {
        this.pacienteR = resp;
      });
      notifyListeners();
      return resp;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<List<PacienteModel>> consultaPacienteNombre(
      String opcion, String proid, String sucid, String nombre) async {
    String url = "https://monte-sinai.herokuapp.com/paciente/listar";
    String op = "opcion=" + opcion;
    String pid = "pro_id=" + proid;
    String sid = "suc_id=" + sucid;
    String urlFinal = url + "?" + op + "&" + pid + "&" + sid;
    try {
      final response = await http.get(urlFinal);
      final pacienteResponse = pacienteListaResponseFromJson(response.body);
      List<PacienteModel> aux = [];
      for (int i = 0; i < pacienteResponse.pacientes.length; i++) {
        if (pacienteResponse.pacientes[i].nombre.contains(nombre)) {
          aux.add(pacienteResponse.pacientes[i]);
        }
      }

      if (aux.isEmpty)
        return pacienteResponse.pacientes;
      else
        return aux;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<String> eliminarPaciente(
      String proid, String pacid, String opcion) async {
    String url = "https://monte-sinai.herokuapp.com/paciente/eliminar";
    String pro = "pro_id=" + proid;
    String pac = "pac_id=" + pacid;
    String op = "opcion=" + opcion;
    String urlFinal = url + "?" + pro + "&" + pac + "&" + op;

    try {
      final response = await http.post(urlFinal);
      var res = (response.body.contains("alta") ? "alta" : "baja");
      return res;
    } on Error catch (e) {
      print("Error: $e");
    }
  }
}
