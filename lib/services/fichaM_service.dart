import 'dart:convert';

import 'package:flutter/material.dart';

class FichaMService with ChangeNotifier {
  int id;
  int codid;
  int proid;
  String pulso;
  String temp;
  String pa;
  String peso;
  String direccion;
  String ident;
  String telefono;
  String fechanac;
  String mail;
  String nombre;
  String fecha;
  String diagnostico;
  String motivo;
  String enfermedadActual;
  String antGo;
  String antPyf;
  String cabeza;
  String abdomen;
  String extrem;
  String torax;
  String pelvis;
  String tratamiento;
  String evolucion;
  int get getId => id;

  set setId(int id) => this.id = id;

  int get getCodid => codid;

  set setCodid(int codid) => this.codid = codid;

  int get getProid => proid;

  set setProid(int proid) => this.proid = proid;

  String get getPulso => pulso;

  set setPulso(String pulso) => this.pulso = pulso;

  String get getTemp => temp;

  set setTemp(String temp) => this.temp = temp;

  String get getPa => pa;

  set setPa(String pa) => this.pa = pa;

  String get getPeso => peso;

  set setPeso(String peso) => this.peso = peso;

  String get getDireccion => direccion;

  set setDireccion(String direccion) => this.direccion = direccion;

  String get getIdent => ident;

  set setIdent(String ident) => this.ident = ident;

  String get getTelefono => telefono;

  set setTelefono(String telefono) => this.telefono = telefono;

  String get getFechanac => fechanac;

  set setFechanac(String fechanac) => this.fechanac = fechanac;

  String get getMail => mail;

  set setMail(String mail) => this.mail = mail;

  String get getNombre => nombre;

  set setNombre(String nombre) => this.nombre = nombre;

  String get getFecha => fecha;

  set setFecha(String fecha) => this.fecha = fecha;

  String get getDiagnostico => diagnostico;

  set setDiagnostico(String diagnostico) => this.diagnostico = diagnostico;

  String get getMotivo => motivo;

  set setMotivo(String motivo) => this.motivo = motivo;

  String get getEnfermedadActual => enfermedadActual;

  set setEnfermedadActual(String enfermedadActual) =>
      this.enfermedadActual = enfermedadActual;

  String get getAntGo => antGo;

  set setAntGo(String antGo) => this.antGo = antGo;

  String get getAntPyf => antPyf;

  set setAntPyf(String antPyf) => this.antPyf = antPyf;

  String get getCabeza => cabeza;

  set setCabeza(String cabeza) => this.cabeza = cabeza;

  String get getAbdomen => abdomen;

  set setAbdomen(String abdomen) => this.abdomen = abdomen;

  String get getExtrem => extrem;

  set setExtrem(String extrem) => this.extrem = extrem;

  String get getTorax => torax;

  set setTorax(String torax) => this.torax = torax;

  String get getPelvis => pelvis;

  set setPelvis(String pelvis) => this.pelvis = pelvis;

  String get getTratamiento => tratamiento;

  set setTratamiento(String tratamiento) => this.tratamiento = tratamiento;

  String get getEvolucion => evolucion;

  set setEvolucion(String evolucion) => this.evolucion = evolucion;
}
