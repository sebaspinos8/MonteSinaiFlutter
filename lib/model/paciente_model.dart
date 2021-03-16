import 'dart:convert';

PacienteModel pacienteFromJson(String str) =>
    PacienteModel.fromJson(json.decode(str));

String pacienteToJson(PacienteModel data) => json.encode(data.toJson());

class PacienteModel {
  PacienteModel(
      {this.id,
      this.perid,
      this.proid,
      this.nombre,
      this.ident,
      this.mail,
      this.fechanac,
      this.direccion,
      this.telefono,
      this.sucid});

  int id, perid, proid, sucid;
  String ident, mail, fechanac, nombre, direccion, telefono;

  factory PacienteModel.fromJson(Map<String, dynamic> json) => PacienteModel(
      id: json["PAC_ID"],
      perid: json["PER_ID"],
      proid: json["PRO_ID"],
      nombre: json["PER_NOMBRE"],
      ident: json["PER_IDENT"],
      mail: json["PER_MAIL"],
      fechanac: json["PER_FEC_NAC"],
      direccion: json["PER_DIRECCION"],
      telefono: json["PER_TELEFONO"],
      sucid: json["SUC_ID"]);

  Map<String, dynamic> toJson() => {
        "PAC_ID": id,
        "PER_ID": perid,
        "PRO_ID": proid,
        "PER_NOMBRE": nombre,
        "PER_IDENT": ident,
        "PER_MAIL": mail,
        "PER_FEC_NAC": fechanac,
        "PER_DIRECCION": direccion,
        "PER_TELEFONO": telefono,
        "SUC_ID": sucid
      };
}
