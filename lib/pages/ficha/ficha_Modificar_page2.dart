import 'package:montesinaiweb/pages/bottomNavBar/menubarfichas.dart';
import 'package:montesinaiweb/services/ficha_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ficha_Modificar_page3.dart';

class FichaModificar2Page extends StatefulWidget {
  static final String routeName = 'FichasA';

  FichaModificar2Page();

  @override
  _FichaModificar2PageState createState() => _FichaModificar2PageState();
}

class _FichaModificar2PageState extends State<FichaModificar2Page> {
  String _nombre = '';
  String _cedula = '';
  String _email = '';
  String _direccion = '';
  String _fecha = '';
  String _consulta = '';
  String _diagnostico = '';
  String _enfactual = '';
  String _ant_go = '';
  String _ants_pers_farm = '';
  String _sucid = '';
  @override
  Widget build(BuildContext context) {
    final fichaService = Provider.of<FichaService>(context, listen: false);
    _nombre = fichaService.ficha.nombre;
    _cedula = fichaService.ficha.ident;
    _email = fichaService.ficha.mail;
    _direccion = fichaService.ficha.direccion;
    _fecha = fichaService.ficha.fecha;
    _diagnostico = fichaService.ficha.diagnostico;
    _consulta = fichaService.ficha.motivo;
    _enfactual = fichaService.ficha.enfermedadActual;
    _ant_go = fichaService.ficha.antGo;
    _ants_pers_farm = fichaService.ficha.antPyf;
    _sucid = fichaService.ficha.sucid.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text("Creando Ficha"),
        ),
        body: IndexedStack(
          index: 0,
          children: [
            ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: <Widget>[
                  _crearDiagnostico(fichaService.ficha.diagnostico),
                  Divider(
                    height: 5,
                  ),
                  _crearConsulta(fichaService.ficha.motivo),
                  Divider(
                    height: 5,
                  ),
                  _crearEnfermedad(fichaService.ficha.enfermedadActual),
                  Divider(
                    height: 5,
                  ),
                  _crearAntGo(fichaService.ficha.antGo),
                  Divider(
                    height: 5,
                  ),
                  _crearAntsPersFarm(fichaService.ficha.antPyf),
                  Divider(
                    height: 20,
                  ),
                  botonesGE(context)
                ]),
          ],
        ));
  }

  Widget _crearDiagnostico(String consulta) {
    return TextField(
        maxLines: 7,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.article)),
        onChanged: (valor) => setState(() {
              _diagnostico = valor;
            }));
  }

  Widget _crearConsulta(String consulta) {
    return TextField(
        maxLines: 7,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.article)),
        onChanged: (valor) => setState(() {
              _consulta = valor;
            }));
  }

  Widget _crearEnfermedad(String enfermedad) {
    return TextField(
        maxLines: 3,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: enfermedad,
            labelText: enfermedad,
            icon: Icon(Icons.chat_outlined)),
        onChanged: (valor) => setState(() {
              _consulta = valor;
            }));
  }

  Widget _crearAntGo(String aux) {
    return TextField(
        maxLines: 5,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: aux,
          labelText: aux,
          //  icon: Icon(Icons.account_circle)
        ),
        onChanged: (valor) => setState(() {
              _consulta = valor;
            }));
  }

  Widget _crearAntsPersFarm(String aux) {
    return TextField(
        maxLines: 5,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: aux,
          labelText: aux,
          //   icon: Icon(Icons.account_circle)
        ),
        onChanged: (valor) => setState(() {
              _consulta = valor;
            }));
  }

  Widget botonesGE(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            // color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Regresar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            color: Colors.blueAccent,
            shape: StadiumBorder(),
          ),
          Spacer(flex: 2),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBarfichas()),
                  ModalRoute.withName("Fichas"));
            },
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            color: Colors.red,
            shape: StadiumBorder(),
          ),
          Spacer(flex: 2),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FichaModificar3Page(
                            nombre: _nombre,
                            cedula: _cedula,
                            email: _email,
                            direccion: _cedula,
                            fecha: _fecha,
                            diagnostico: _diagnostico,
                            consulta: _consulta,
                            enfactual: _enfactual,
                            antgo: _ant_go,
                            antspyf: _ants_pers_farm,
                          )));
            },
            child: const Text('Siguiente',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            color: Colors.blueAccent,
            shape: StadiumBorder(),
          ),
          Spacer()
        ],
      ),
    );
  }
}
