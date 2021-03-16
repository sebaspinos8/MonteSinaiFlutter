// To parse this JSON data, do
//
//     final usuariosListaResponse = usuariosListaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:montesinaiweb/model/paciente_model.dart';

PacienteListaResponse pacienteListaResponseFromJson(String str) =>
    PacienteListaResponse.fromJson(json.decode(str));

String pacienteListaResponseToJson(PacienteListaResponse data) =>
    json.encode(data.toJson());

class PacienteListaResponse {
  PacienteListaResponse({
    this.pacientes,
  });

  List<PacienteModel> pacientes;

  factory PacienteListaResponse.fromJson(Map<String, dynamic> json) =>
      PacienteListaResponse(
        pacientes: List<PacienteModel>.from(
            json["pacientes"].map((x) => PacienteModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pacientes": List<dynamic>.from(pacientes.map((x) => x.toJson())),
      };
}
