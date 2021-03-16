import 'package:montesinaiweb/model/ficha_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:montesinaiweb/pages/bottomNavBar/menubarfichas.dart';

import 'ficha_Agregar_page3.dart';

class FichaAgregar2Page extends StatefulWidget {
  static final String routeName = 'FichasA';
  final FichaModel fichaAux;
  FichaAgregar2Page({Key key, this.fichaAux}) : super(key: key);
  @override
  _FichaAgregar2PageState createState() => _FichaAgregar2PageState();
}

class _FichaAgregar2PageState extends State<FichaAgregar2Page> {
  String _consulta = '';
  String _enfactual = '';
  String _ant_go = '';
  String _ants_pers_farm = '';

  @override
  Widget build(BuildContext context) {
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
                  _crearDiagnostico(),
                  Divider(
                    height: 5,
                  ),
                  _crearConsulta(),
                  Divider(
                    height: 5,
                  ),
                  _crearEnfermedad(),
                  Divider(
                    height: 5,
                  ),
                  _crearAntGo(),
                  Divider(
                    height: 5,
                  ),
                  _crearAntsPersFarm(),
                  Divider(
                    height: 20,
                  ),
                  botonesGE(context)
                ]),
          ],
        ));
  }

  Widget _crearConsulta() {
    return TextField(
        maxLines: 7,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Motivo de la consulta',
            labelText: 'Consulta',
            icon: Icon(Icons.article)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.motivo = valor;
            }));
  }

  Widget _crearDiagnostico() {
    return TextField(
        maxLines: 7,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Diagnostico del paciente',
            labelText: 'Diagnotico',
            icon: Icon(Icons.article)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.diagnostico = valor;
            }));
  }

  Widget _crearEnfermedad() {
    return TextField(
        maxLines: 3,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // hintText: '',
            labelText: 'Enfermedad Actual',
            icon: Icon(Icons.chat_outlined)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.enfermedadActual = valor;
            }));
  }

  Widget _crearAntGo() {
    return TextField(
        maxLines: 5,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          // hintText: 'Motivo de la consulta',
          labelText: 'Ant Go',
          //  icon: Icon(Icons.account_circle)
        ),
        onChanged: (valor) => setState(() {
              widget.fichaAux.antGo = valor;
            }));
  }

  Widget _crearAntsPersFarm() {
    return TextField(
        maxLines: 5,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //  hintText: ' ',
          labelText: 'Ants Pers Farm',
          //   icon: Icon(Icons.account_circle)
        ),
        onChanged: (valor) => setState(() {
              widget.fichaAux.antPyf = valor;
            }));
  }

  Widget botonesGE(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(),
          TextButton(
            //padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            // color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Regresar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blueAccent,
              onSurface: Colors.grey,
              //side: BorderSide(color: Colors.red, width: 5),
            ),
          ),
          Spacer(flex: 2),
          TextButton(
            //padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBarfichas()),
                  ModalRoute.withName("Fichas"));
            },
            child: const Text('Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.red,
              onSurface: Colors.grey,
              side: BorderSide(color: Colors.red, width: 5),
            ),
            //color: Colors.red,
            //shape: StadiumBorder(),
          ),
          Spacer(flex: 2),
          TextButton(
            //padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FichaAgregar3Page(
                            fichaAux: widget.fichaAux,
                          )));
            },
            child: const Text('Siguiente',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blueAccent,
              onSurface: Colors.grey,
              //side: BorderSide(color: Colors.red, width: 5),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
