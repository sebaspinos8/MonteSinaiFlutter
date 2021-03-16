import 'dart:convert';

FichaUltimaModel fichaFromJson(String str) =>
    FichaUltimaModel.fromJson(json.decode(str));

String fichaToJson(FichaUltimaModel data) => json.encode(data.toJson());

class FichaUltimaModel {
  FichaUltimaModel(
      {this.id,
      this.codid,
      this.fecha,
      this.diagnostico,
      this.motivo,
      this.enfermedadActual,
      this.antGo,
      this.antPyf,
      this.pulso,
      this.temp,
      this.pa,
      this.peso,
      this.cabeza,
      this.abdomen,
      this.extrem,
      this.torax,
      this.pelvis,
      this.tratamiento,
      this.evolucion,
      this.proid,
      this.pacid,
      this.sucid,
      this.estado});

  int id, codid, proid, pacid, sucid;
  String estado,
      pulso,
      temp,
      pa,
      peso,
      direccion,
      ident,
      telefono,
      fechanac,
      mail,
      nombre,
      fecha,
      diagnostico,
      motivo,
      enfermedadActual,
      antGo,
      antPyf,
      cabeza,
      abdomen,
      extrem,
      torax,
      pelvis,
      tratamiento,
      evolucion;

  factory FichaUltimaModel.fromJson(Map<String, dynamic> json) =>
      FichaUltimaModel(
          id: json["FIC_ID"],
          codid: json["FIC_COD_ID"],
          fecha: json["FIC_FECHA"],
          diagnostico: json["FIC_DIAGNOSTICO"],
          motivo: json["FIC_MOTIVO"],
          enfermedadActual: json["FIC_ENFER_ACT"],
          antGo: json["FIC_ANT_GO"],
          antPyf: json["FIC_ANT_PYF"],
          pulso: json["FIC_PULSO"],
          temp: json["FIC_TEMP"],
          pa: json["FIC_PA"],
          peso: json["FIC_PESO"],
          cabeza: json["FIC_CABEZA"],
          abdomen: json["FIC_ABDOMEN"],
          extrem: json["FIC_EXTREM"],
          torax: json["FIC_TORAX"],
          pelvis: json["FIC_PELVIS"],
          tratamiento: json["FIC_TRATAMIENTO"],
          evolucion: json["FIC_EVOLUCION"],
          proid: json["PRO_ID"],
          pacid: json["PAC_ID"],
          sucid: json["SUC_ID"],
          estado: json["FIC_ESTADO"]);

  Map<String, dynamic> toJson() => {
        "FIC_ID": id,
        "FIC_COD_ID": proid,
        "FIC_FECHA": fecha,
        "FIC_DIAGNOSTICO": diagnostico,
        "FIC_MOTIVO": motivo,
        "FIC_ENFER_ACT": enfermedadActual,
        "FIC_ANT_GO": antGo,
        "FIC_ANT_PYF": antPyf,
        "FIC_PULSO": pulso,
        "FIC_TEMP": temp,
        "FIC_PA": pa,
        "FIC_PESO": peso,
        "FIC_CABEZA": cabeza,
        "FIC_ABDOMEN": abdomen,
        "FIC_EXTREM": extrem,
        "FIC_TORAX": torax,
        "FIC_PELVIS": pelvis,
        "FIC_TRATAMIENTO": tratamiento,
        "FIC_EVOLUCION": evolucion,
        "PRO_ID": proid,
        "PAC_ID": pacid,
        "SUC_ID": sucid,
        "FIC_ESTADO": estado
      };
}
