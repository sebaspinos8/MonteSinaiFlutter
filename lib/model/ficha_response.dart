// To parse this JSON data, do
//
//     final usuariosListaResponse = usuariosListaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:montesinaiweb/model/ficha_model.dart';

FichaListaResponse fichaListaResponseFromJson(String str) =>
    FichaListaResponse.fromJson(json.decode(str));

String fichaListaResponseToJson(FichaListaResponse data) =>
    json.encode(data.toJson());

class FichaListaResponse {
  FichaListaResponse({
    this.fichas,
  });

  List<FichaModel> fichas;

  factory FichaListaResponse.fromJson(Map<String, dynamic> json) =>
      FichaListaResponse(
        fichas: List<FichaModel>.from(
            json["fichas"].map((x) => FichaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fichas": List<dynamic>.from(fichas.map((x) => x.toJson())),
      };
}
