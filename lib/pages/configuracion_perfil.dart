import 'package:montesinaiweb/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:montesinaiweb/pages/sucursal/SucursalAgregarPage.dart';

class ConfiguracionPage extends StatefulWidget {
  static final String routeName = 'Configuracion';
  ConfiguracionPage({Key key}) : super(key: key);

  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<ConfiguracionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Configuración'),
        elevation: 20,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          _perfilBox(),
          // SizedBox(height: 15.0),
          _consultorioBox(),
          //  SizedBox(height: 15.0),
          _logoutBox(),
          // SizedBox(height: 15.0),
          _informacionBox(),
          // SizedBox(height: 15.0),
        ],
      ),
    );
  }

  Widget _consultorioBox() {
    return Card(
      elevation: 10.0, //sombreado
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0)), //redondeo de card en las esquinas
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.local_hospital_outlined,
            color: Colors.blue,
            size: 50,
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SucursalAgregarPage()));
          },
          title: Text('Agregar Sucursal', style: TextStyle(fontSize: 20)),
        ),
      ]),
    );
  }

  Widget _perfilBox() {
    return Card(
      elevation: 10.0, //sombreado
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0)), //redondeo de card en las esquinas
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.blue,
            size: 50,
          ),
          onTap: () {},
          title: Text('Perfil', style: TextStyle(fontSize: 20)),
        ),
      ]),
    );
  }

  Widget _logoutBox() {
    return Card(
      elevation: 10.0, //sombreado
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0)), //redondeo de card en las esquinas
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.blue,
            size: 50,
          ),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          title: Text('Salir', style: TextStyle(fontSize: 20)),
        ),
      ]),
    );
  }

  Widget _informacionBox() {
    return Card(
      elevation: 10.0, //sombreado
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0)), //redondeo de card en las esquinas
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: Colors.blue,
            size: 50,
          ),
          onTap: () {},
          title: Text(
            'Información',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ]),
    );
  }
}
