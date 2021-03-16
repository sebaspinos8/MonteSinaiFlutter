import 'package:montesinaiweb/services/paciente_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bottomNavBar/menubarconfig.dart';

class SucursalAgregarPage extends StatefulWidget {
  static final String routeName = 'SucursalA';

  SucursalAgregarPage({Key key}) : super(key: key);

  @override
  _SucursalAgregarPageState createState() => _SucursalAgregarPageState();
}

class _SucursalAgregarPageState extends State<SucursalAgregarPage> {
  String _nombre = '';
  String _descripcion = '';
  String _direccion = '';

  //conecta  el input fecha con el controlador

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Consultorios"),
        ),
        body: IndexedStack(
          index: 0,
          children: [
            ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: <Widget>[
                  _crearNombre(),
                  Divider(),
                  _crearDescripcion(),
                  Divider(),
                  _crearDireccion(),
                  Divider(),
                  Divider(),
                  Divider(),
                  Divider(),
                  Divider(),
                  botonesGE(context)
                ]),
          ],
        ));
  }

  Widget _crearNombre() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Nombre del Consultorio',
            labelText: 'Consultorio',
            icon: Icon(Icons.account_circle)),
        onChanged: (valor) => setState(() {
              _nombre = valor;
            }));
  }

  Widget _crearDescripcion() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Descripcion del Consultorio',
            labelText: 'Descripcion',
            icon: Icon(Icons.search)),
        onChanged: (valor) => setState(() {
              _direccion = valor;
            }));
  }

  Widget _crearDireccion() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Dirección del Consultorio',
            labelText: 'Dirección',
            icon: Icon(Icons.location_on)),
        onChanged: (valor) => setState(() {
              _direccion = valor;
            }));
  }
}

Widget botonesGE(BuildContext context) {
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Spacer(),
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
          // color: Colors.red,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BottomNavBarconfig()));
          },
          child: const Text('Cancelar',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.red,
          shape: StadiumBorder(),
        ),
        Spacer(),
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
          //color: Colors.blue,
          onPressed: () {
            CupertinoAlertDialog(
              content: Text('Consultorio creado correctamente'),
            );
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BottomNavBarconfig()));
          },
          child: const Text(
            'Agregar',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Theme.of(context).accentColor,
          shape: StadiumBorder(),
        ),
        Spacer(),
      ],
    ),
  );
}

String fechita(String fecha) {
  List<String> auxf = fecha.split('/');
  return auxf[2] + "/" + auxf[1] + "/" + auxf[0];
}
