import 'dart:convert';

SucursalModel loginResponseFromJson(String str) =>
    SucursalModel.fromJson(json.decode(str));

String loginResponseToJson(SucursalModel data) => json.encode(data.toJson());

class SucursalModel {
  SucursalModel({this.sucid, this.nombre, this.direccion});

  int sucid;
  String nombre, direccion;

  factory SucursalModel.fromJson(Map<String, dynamic> json) => SucursalModel(
      sucid: json["SUC_ID"],
      nombre: json["SUC_NOMBRE"],
      direccion: json["SUC_DIRECCION"]);

  Map<String, dynamic> toJson() => {
        "SUC_ID": sucid,
        "SUC_NOMBRE": nombre,
        "SUC_DIRECCION": direccion,
      };
}
