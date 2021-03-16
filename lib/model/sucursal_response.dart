// To parse this JSON data, do
//
//     final usuariosListaResponse = usuariosListaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:montesinaiweb/model/sucursal_model.dart';

SucursalListaResponse sucursalListaResponseFromJson(String str) =>
    SucursalListaResponse.fromJson(json.decode(str));

String sucursalListaResponseToJson(SucursalListaResponse data) =>
    json.encode(data.toJson());

class SucursalListaResponse {
  SucursalListaResponse({
    this.sucursales,
  });

  List<SucursalModel> sucursales;

  factory SucursalListaResponse.fromJson(Map<String, dynamic> json) =>
      SucursalListaResponse(
        sucursales: List<SucursalModel>.from(
            json["sucursales"].map((x) => SucursalModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sucursales": List<dynamic>.from(sucursales.map((x) => x.toJson())),
      };
}
