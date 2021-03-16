import 'dart:convert';

import 'package:montesinaiweb/model/fichaUltima_model.dart';
import 'package:montesinaiweb/model/ficha_model.dart';
import 'package:montesinaiweb/model/ficha_response.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class FichaService with ChangeNotifier {
  FichaUltimaModel fichaR;
  FichaModel ficha;

  Future<String> agregarFicha(FichaModel aux) async {
    String url = "https://monte-sinai.herokuapp.com/ficha/agr_mod";
    String fec = "fecha=" + aux.fecha;
    String dia = "diagnostico=" + aux.diagnostico;
    String moti = "motivo=" + aux.motivo;
    String enfA = "enfermedad_actual=" + aux.enfermedadActual;
    String atg = "ant_go=" + aux.antGo;
    String apf = "ant_pyf=" + aux.antPyf;
    String pul = "pulso=" + aux.pulso;
    String tmp = "temp=" + aux.temp;
    String pa1 = "pa=" + aux.pa;
    String pes = "peso=" + aux.peso;
    String cbz = "cabeza=" + aux.cabeza;
    String abd = "abdomen=" + aux.abdomen;
    String ext = "extremidades=" + aux.extrem;
    String tx = "torax=" + aux.torax;
    String pel = "pelvis=" + aux.pelvis;
    String tratam = "tratamiento=" + aux.tratamiento;
    String evol = "evolucion=" + aux.evolucion;
    String sucid1 = "suc_id=" + aux.sucid.toString();
    String proid1 = "pro_id=" + aux.proid.toString();
    String pacid1 = "pac_id=" + aux.pacid.toString();
    String urlFinal = url +
        "?" +
        "fic_id=0" +
        "&" +
        fec +
        "&" +
        dia +
        "&" +
        moti +
        "&" +
        enfA +
        "&" +
        atg +
        "&" +
        apf +
        "&" +
        pul +
        "&" +
        tmp +
        "&" +
        pa1 +
        "&" +
        pes +
        "&" +
        cbz +
        "&" +
        abd +
        "&" +
        ext +
        "&" +
        tx +
        "&" +
        pel +
        "&" +
        tratam +
        "&" +
        evol +
        "&" +
        sucid1 +
        "&" +
        proid1 +
        "&" +
        pacid1;
    print(urlFinal);
    try {
      final response = await http.post(urlFinal);
      var res =
          (response.body.contains("ingresado") ? "ingresar" : "modificar");
      return res;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<FichaUltimaModel> ultimaFichaPaciente(
      String proid, String pacid, String sucid) async {
    String url = "https://monte-sinai.herokuapp.com/ficha/ultimaFicha";
    String pid = "pro_id=" + proid;
    String paid = "pac_id=" + pacid;
    String sid = "suc_id=" + sucid;
    String urlFinal = url + "?" + paid + "&" + pid + "&" + sid;
    FichaUltimaModel resp;
    try {
      final response = await http.get(urlFinal);
      resp = FichaUltimaModel.fromJson(
        json.decode(response.body),
      );
      Future.delayed(Duration.zero, () {
        this.fichaR = resp;
      });

      notifyListeners();
      return resp;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<FichaModel> consultaFicha(String ficid) async {
    String url = "https://monte-sinai.herokuapp.com/ficha/consulta";
    String fid = "fic_id=" + ficid;
    String urlFinal = url + "?" + fid;
    FichaModel resp;
    try {
      final response = await http.get(urlFinal);
      resp = FichaModel.fromJson(
        json.decode(response.body),
      );
      Future.delayed(Duration.zero, () {
        this.ficha = resp;
      });
      notifyListeners();
      return resp;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<List<FichaModel>> listarFicha(
      String opcion, String proid, String sucid) async {
    String url = "https://monte-sinai.herokuapp.com/ficha/listar";
    String op = "opcion=" + opcion;
    String id = "pro_id=" + proid;
    String sid = "suc_id=" + sucid;
    String urlFinal = url + "?" + op + "&" + id + "&" + sid;
    try {
      final response = await http.get(urlFinal);
      final fichaResponse = fichaListaResponseFromJson(response.body);
      return fichaResponse.fichas;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<List<FichaModel>> consultaFichaNombre(
      String opcion, String proid, String sucid, String nombre) async {
    String url = "https://monte-sinai.herokuapp.com/ficha/listar";
    String op = "opcion=" + opcion;
    String pid = "pro_id=" + proid;
    String sid = "suc_id=" + sucid;
    String urlFinal = url + "?" + op + "&" + pid + "&" + sid;
    try {
      final response = await http.get(urlFinal);
      final fichaResponse = fichaListaResponseFromJson(response.body);
      List<FichaModel> aux = [];
      for (int i = 0; i < fichaResponse.fichas.length; i++) {
        if (fichaResponse.fichas[i].nombre.contains(nombre)) {
          aux.add(fichaResponse.fichas[i]);
        }
      }

      if (aux.isEmpty)
        return fichaResponse.fichas;
      else
        return aux;
    } on Error catch (e) {
      print("Error: $e");
    }
  }

  Future<String> eliminarFicha(String ficid, String opcion) async {
    String url = "https://monte-sinai.herokuapp.com/ficha/eliminar";
    String fid = "fic_id=" + ficid;
    String op = "opcion=" + opcion;
    String urlFinal = url + "?" + fid + "&" + op;

    try {
      final response = await http.post(urlFinal);
      var res = (response.body.contains("alta") ? "alta" : "baja");
      return res;
    } on Error catch (e) {
      print("Error: $e");
    }
  }
}
