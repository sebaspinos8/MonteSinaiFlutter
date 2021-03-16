import 'dart:convert';

CitaModel citaFromJson(String str) => CitaModel.fromJson(json.decode(str));

String citaToJson(CitaModel data) => json.encode(data.toJson());

class CitaModel {
  CitaModel(
      {this.id,
      this.nombre,
      this.fecha,
      this.hora,
      this.asunto,
      this.proid,
      this.pacid,
      this.sucid});

  int proid, id, pacid, sucid;
  String nombre, fecha, hora, asunto;

  factory CitaModel.fromJson(Map<String, dynamic> json) => CitaModel(
        id: json["CIT_COD_ID"],
        nombre: json["PER_NOMBRE"],
        fecha: json["CIT_FECHA"],
        hora: json["CIT_HORA"],
        asunto: json["CIT_ASUNTO"],
        proid: json["PRO_ID"],
        pacid: json["PAC_ID"],
        sucid: json["SUC_ID"],
      );

  Map<String, dynamic> toJson() => {
        "CIT_COD_ID": id,
        "PER_NOMBRE": nombre,
        "CIT_FECHA": fecha,
        "CIT_HORA": hora,
        "CIT_ASUNTO": asunto,
        "PRO_ID": proid,
        "PAC_ID": pacid,
        "SUC_ID": sucid,
      };
}
