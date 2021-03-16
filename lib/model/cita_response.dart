// To parse this JSON data, do
//
//     final usuariosListaResponse = usuariosListaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:montesinaiweb/model/cita_model.dart';

CitaListaResponse citaListaResponseFromJson(String str) =>
    CitaListaResponse.fromJson(json.decode(str));

String citaListaResponseToJson(CitaListaResponse data) =>
    json.encode(data.toJson());

class CitaListaResponse {
  CitaListaResponse({
    this.citas,
  });

  List<CitaModel> citas;

  factory CitaListaResponse.fromJson(Map<String, dynamic> json) =>
      CitaListaResponse(
        citas: List<CitaModel>.from(
            json["citas"].map((x) => CitaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "citas": List<dynamic>.from(citas.map((x) => x.toJson())),
      };
}
