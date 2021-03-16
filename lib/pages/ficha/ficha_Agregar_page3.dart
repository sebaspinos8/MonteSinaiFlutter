import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/model/ficha_model.dart';
import 'package:montesinaiweb/pages/bottomNavBar/menubarfichas.dart';
import 'package:montesinaiweb/services/ficha_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FichaAgregar3Page extends StatefulWidget {
  static final String routeName = 'FichasA';
  final FichaModel fichaAux;
  FichaAgregar3Page({Key key, this.fichaAux}) : super(key: key);

  @override
  _FichaAgregar3PageState createState() => _FichaAgregar3PageState();
}

class _FichaAgregar3PageState extends State<FichaAgregar3Page> {
  String _nombre = '';
  String _cedula = '';
  String _email = '';
  String _direccion = '';
  String _fecha = '';
  Methods metodos = new Methods();
  var thisInstant = new DateTime.now();

  //conecta  el input fecha con el controlador

  TextEditingController _inputFieldDateController = new TextEditingController();

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
                  _crearPulso(),
                  Divider(
                    height: 5,
                  ),
                  _crearTemp(),
                  Divider(
                    height: 5,
                  ),
                  _crearPA(),
                  Divider(
                    height: 5,
                  ),
                  _crearPeso(),
                  Divider(
                    height: 5,
                  ),
                  _crearCabeza(),
                  Divider(
                    height: 5,
                  ),
                  _crearAbdomen(),
                  Divider(
                    height: 5,
                  ),
                  _crearExtremidades(),
                  Divider(
                    height: 5,
                  ),
                  _crearTorso(),
                  Divider(
                    height: 5,
                  ),
                  _crearPelvis(),
                  Divider(
                    height: 20,
                  ),
                  _crearTratamiento(),
                  Divider(
                    height: 20,
                  ),
                  _crearEvolucion(),
                  Divider(
                    height: 20,
                  ),
                  botonesGE(context)
                ]),
          ],
        ));
  }

  Widget _crearPulso() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            labelText: 'Pulso',
            icon: Icon(Icons.favorite_border)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.pulso = valor;
            }));
  }

  Widget _crearTemp() {
    return TextField(
        keyboardType: TextInputType.number,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'ingrese la cedula',
            labelText: 'Temperatura',
            icon: Icon(Icons.sick_rounded)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.temp = valor;
            }));
  }

  Widget _crearPA() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            labelText: 'PA',
            icon: Icon(Icons.account_circle)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.pa = valor;
            }));
  }

  Widget _crearPeso() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // hintText: 'Nombre de la persona',
            labelText: 'Peso',
            icon: Icon(Icons.self_improvement)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.peso = valor;
            }));
  }

  Widget _crearCabeza() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // hintText: 'Nombre de la persona',
            labelText: 'Cabeza',
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.cabeza = valor;
            }));
  }

  Widget _crearAbdomen() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            labelText: 'Abdomen',
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.abdomen = valor;
            }));
  }

  Widget _crearExtremidades() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            labelText: 'Extremidades',
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.extrem = valor;
            }));
  }

  Widget _crearTorso() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // hintText: 'Nombre de la persona',
            labelText: 'Torax',
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.torax = valor;
            }));
  }

  Widget _crearPelvis() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            labelText: 'Pelvis',
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.pelvis = valor;
            }));
  }

  Widget _crearTratamiento() {
    return TextField(
        maxLines: 7,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Tratamiento del paciente',
            labelText: 'Tratamiento',
            icon: Icon(Icons.article)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.tratamiento = valor;
            }));
  }

  Widget _crearEvolucion() {
    return TextField(
        maxLines: 7,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Evolucion del paciente',
            labelText: 'Evolucion',
            icon: Icon(Icons.article)),
        onChanged: (valor) => setState(() {
              widget.fichaAux.evolucion = valor;
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
          Spacer(),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            // color: Colors.red,
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
          Spacer(),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            color: Colors.blueAccent,
            onPressed: () {
              CupertinoAlertDialog(
                content: Text('Ficha ingresada correctamente'),
              );
              final fichaService =
                  Provider.of<FichaService>(context, listen: false);
              final resp =
                  fichaService.agregarFicha(widget.fichaAux).then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavBarfichas()),
                    ModalRoute.withName("Fichas"));
              });
            },
            child: const Text(
              'Guardar',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            // color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
