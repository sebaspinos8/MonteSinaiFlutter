import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/model/ficha_model.dart';
import 'package:montesinaiweb/pages/bottomNavBar/menubarfichas.dart';
import 'package:montesinaiweb/services/auth_service.dart';
import 'package:montesinaiweb/services/ficha_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:provider/provider.dart';

class FichaModificar3Page extends StatefulWidget {
  static final String routeName = 'FichasA';

  String nombre = '';
  String cedula = '';
  String email = '';
  String direccion = '';
  String fecha = '';
  String diagnostico = '';
  String consulta = '';
  String enfactual = '';
  String antgo = '';
  String antspyf = '';

  FichaModificar3Page(
      {this.nombre,
      this.cedula,
      this.email,
      this.direccion,
      this.fecha,
      this.diagnostico,
      this.consulta,
      this.enfactual,
      this.antgo,
      this.antspyf});

  @override
  _FichaModificar3PageState createState() => _FichaModificar3PageState();
}

class _FichaModificar3PageState extends State<FichaModificar3Page> {
  Methods metodos = new Methods();
  String _pulso = '';
  String _temp = '';
  String _pa = '';
  String _peso = '';
  String _cabeza = '';
  String _abdomen = '';
  String _extrem = '';
  String _torax = '';
  String _pelvis = '';
  String _nombre = '';
  String _cedula = '';
  String _tratam = '';
  String _evolucion = '';
  String _fechanac = '';
  String _telefono = '';
  int _id = 0;
  int _codid = 0;
  int _sucid = 0;
  int _proid = 0;
  int _pacid = 0;

  var thisInstant = new DateTime.now();

  //conecta  el input fecha con el controlador

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fichaService = Provider.of<FichaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);
    _id = fichaService.ficha.id;
    _pulso = fichaService.ficha.pulso;
    _temp = fichaService.ficha.temp;
    _pa = fichaService.ficha.pa;
    _peso = fichaService.ficha.peso;
    _cabeza = fichaService.ficha.cabeza;
    _abdomen = fichaService.ficha.abdomen;
    _extrem = fichaService.ficha.extrem;
    _torax = fichaService.ficha.torax;
    _pelvis = fichaService.ficha.pelvis;
    _tratam = fichaService.ficha.tratamiento;
    _evolucion = fichaService.ficha.evolucion;
    _fechanac = fichaService.ficha.fechanac;
    _codid = fichaService.ficha.codid;
    _telefono = fichaService.ficha.telefono;
    _pacid = fichaService.ficha.pacid;
    _proid = fichaService.ficha.proid;
    _sucid = sucursalService.sucursalR.sucid;
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
                  _crearPulso(fichaService.ficha.pulso),
                  Divider(
                    height: 5,
                  ),
                  _crearTemp(fichaService.ficha.temp),
                  Divider(
                    height: 5,
                  ),
                  _crearPA(fichaService.ficha.pa),
                  Divider(
                    height: 5,
                  ),
                  _crearPeso(fichaService.ficha.peso),
                  Divider(
                    height: 5,
                  ),
                  _crearCabeza(fichaService.ficha.cabeza),
                  Divider(
                    height: 5,
                  ),
                  _crearAbdomen(fichaService.ficha.abdomen),
                  Divider(
                    height: 5,
                  ),
                  _crearExtremidades(fichaService.ficha.extrem),
                  Divider(
                    height: 5,
                  ),
                  _crearTorso(fichaService.ficha.torax),
                  Divider(
                    height: 5,
                  ),
                  _crearPelvis(fichaService.ficha.pelvis),
                  Divider(
                    height: 20,
                  ),
                  _crearTratamiento(fichaService.ficha.tratamiento),
                  Divider(
                    height: 20,
                  ),
                  _crearEvolucion(fichaService.ficha.evolucion),
                  Divider(
                    height: 20,
                  ),
                  botonesGE(context)
                ]),
          ],
        ));
  }

  Widget _crearPulso(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.favorite_border)),
        onChanged: (valor) => setState(() {
              _pulso = valor;
            }));
  }

  Widget _crearTemp(String consulta) {
    return TextField(
        keyboardType: TextInputType.number,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'ingrese la cedula',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.sick_rounded)),
        onChanged: (valor) => setState(() {
              _temp = valor;
            }));
  }

  Widget _crearPA(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.account_circle)),
        onChanged: (valor) => setState(() {
              _pa = valor;
            }));
  }

  Widget _crearPeso(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.self_improvement)),
        onChanged: (valor) => setState(() {
              _peso = valor;
            }));
  }

  Widget _crearCabeza(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              _cabeza = valor;
            }));
  }

  Widget _crearAbdomen(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              _abdomen = valor;
            }));
  }

  Widget _crearExtremidades(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              _extrem = valor;
            }));
  }

  Widget _crearTorso(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              _torax = valor;
            }));
  }

  Widget _crearPelvis(String consulta) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            //  hintText: 'Nombre de la persona',
            hintText: consulta,
            labelText: consulta,
            icon: Icon(Icons.folder_shared_outlined)),
        onChanged: (valor) => setState(() {
              _pelvis = valor;
            }));
  }

  Widget _crearTratamiento(String consulta) {
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
              _tratam = valor;
            }));
  }

  Widget _crearEvolucion(String consulta) {
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
              _evolucion = valor;
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
              Navigator.pop(
                context,
              );
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
              FichaModel fichaAux = new FichaModel();
              fichaAux.id = _id;
              fichaAux.codid = _codid;
              fichaAux.nombre = widget.nombre;
              fichaAux.fechanac = _fechanac;
              fichaAux.direccion = widget.direccion;
              fichaAux.ident = widget.cedula;
              fichaAux.telefono = _telefono;
              fichaAux.mail = widget.email;
              fichaAux.fecha = metodos.formatoFechaDMA(
                  widget.fecha.substring(0, 10).replaceAll('-', '/'));
              fichaAux.diagnostico = widget.diagnostico;
              fichaAux.motivo = widget.consulta;
              fichaAux.enfermedadActual = widget.enfactual;
              fichaAux.antGo = widget.antgo;
              fichaAux.antPyf = widget.antspyf;
              fichaAux.pulso = _pulso;
              fichaAux.temp = _temp;
              fichaAux.pa = _pa;
              fichaAux.peso = _peso;
              fichaAux.cabeza = _cabeza;
              fichaAux.abdomen = _abdomen;
              fichaAux.extrem = _extrem;
              fichaAux.torax = _torax;
              fichaAux.pelvis = _pelvis;
              fichaAux.tratamiento = _tratam;
              fichaAux.evolucion = _evolucion;
              fichaAux.sucid = _sucid;
              fichaAux.proid = _proid;
              fichaAux.pacid = _pacid;
              final fichaService =
                  Provider.of<FichaService>(context, listen: false);
              final resp = fichaService.agregarFicha(fichaAux).then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavBarfichas()));
              });

              CupertinoAlertDialog(
                content: Text('Usuario ingresado correctamente'),
              );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBarfichas()),
                  ModalRoute.withName("Fichas"));
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
