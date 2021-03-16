import 'package:montesinaiweb/model/sucursal_model.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:ui';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  //obtener nombre de la ruta pro medio del routeName sin necesidad de ir al archivo
  static final String routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SucursalModel sucursal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sucursalService = Provider.of<SucursalUService>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Opciones Clinicas',
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text(
                  'Bienvenido ha su menú de su Consultorio: ' +
                      sucursalService.sucursalR.nombre,
                  style: TextStyle(color: Colors.blue[700], fontSize: 18.0)),
              Container(
                width: 650,
                height: 450,
                child: Image(image: AssetImage('assets/Diabetes.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
