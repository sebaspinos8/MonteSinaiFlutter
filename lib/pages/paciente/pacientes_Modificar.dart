import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/model/paciente_model.dart';

import 'package:montesinaiweb/services/auth_service.dart';
import 'package:montesinaiweb/services/paciente_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PacientesModificarPage extends StatefulWidget {
  static final String routeName = 'PacientesM';

  PacientesModificarPage({Key key}) : super(key: key);

  @override
  _PacientesModificarPageState createState() => _PacientesModificarPageState();
}

class _PacientesModificarPageState extends State<PacientesModificarPage> {
  String _nombre = '';
  String _cedula = '';
  String _email = '';
  String _direccion = '';
  String _telefono = '';
  String _fecha = '';
  Methods metodos = new Methods();

  //conecta  el input fecha con el controlador

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pacienteuService =
        Provider.of<PacienteService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Modificar Pacientes"),
        ),
        body: IndexedStack(
          index: 0,
          children: [
            ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: <Widget>[
                  _crearNombre(pacienteuService.pacienteR.nombre),
                  Divider(),
                  _crearCedula(pacienteuService.pacienteR.ident),
                  Divider(),
                  _crearCorreo(pacienteuService.pacienteR.mail),
                  Divider(),
                  _crearDireccion(pacienteuService.pacienteR.direccion),
                  Divider(),
                  _crearTelefono(pacienteuService.pacienteR.telefono),
                  Divider(),
                  _crearFechaNac(context, pacienteuService.pacienteR.fechanac),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
                  botonesGE(context, pacienteuService.pacienteR)
                ]),
          ],
        ));
  }

  Widget _crearNombre(String nombre) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: nombre,
            labelText: nombre,
            icon: Icon(Icons.account_circle)),
        onChanged: (valor) => setState(() {
              _nombre = valor;
            }));
  }

  Widget _crearDireccion(String dir) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: dir,
            labelText: dir,
            icon: Icon(Icons.directions)),
        onChanged: (valor) => setState(() {
              _direccion = valor;
            }));
  }

  Widget _crearTelefono(String telf) {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: telf,
            labelText: telf,
            icon: Icon(Icons.add_call)),
        onChanged: (valor) => setState(() {
              _telefono = valor;
            }));
  }

  Widget _crearCedula(String ident) {
    return TextField(
        keyboardType: TextInputType.number,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: ident,
            labelText: ident,
            icon: Icon(Icons.account_balance_wallet_rounded)),
        onChanged: (valor) => setState(() {
              _cedula = valor;
            }));
  }

  Widget _crearCorreo(String mail) {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: mail,
            labelText: mail,
            suffixIcon: Icon(Icons.alternate_email),
            icon: Icon(Icons.email)),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearFechaNac(BuildContext context, String fnac) {
    return TextField(
        enableInteractiveSelection: true,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: fnac,
            labelText: fnac,
            suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: Icon(Icons.calendar_today)),
        onTap: () async {
          final picked = await showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: new DateTime(1950),
              lastDate: new DateTime(2030),
              locale: Locale('es', 'ES'));
          if (picked != null) {
            setState(() {
              _inputFieldDateController.text = picked.toString();
              _fecha = picked.toString();
            });
          }
        });
  }

  Widget botonesGE(BuildContext context, PacienteModel paciente) {
    if (_fecha == '') _fecha = paciente.fechanac;
    if (_nombre == '') _nombre = paciente.nombre;
    if (_direccion == '') _direccion = paciente.direccion;
    if (_telefono == '') _telefono = paciente.telefono;
    if (_email == '') _email = paciente.mail;
    if (_cedula == '') _cedula = paciente.ident;
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
            onPressed: () {
              PacienteService pacienteService = new PacienteService();
              AuthService authService =
                  Provider.of<AuthService>(context, listen: false);
              SucursalUService sucursalService =
                  Provider.of<SucursalUService>(context, listen: false);
              Future<String> res = pacienteService.agregarPaciente(
                  paciente.perid.toString(),
                  _nombre.toUpperCase(),
                  _cedula.trim().toUpperCase(),
                  _email.trim().toUpperCase(),
                  metodos.formatoFechaDMA(
                      _fecha.substring(0, 10).replaceAll('-', '/')),
                  _direccion.trim().toUpperCase(),
                  _telefono.trim().toUpperCase(),
                  sucursalService.sucursalR.sucid.toString(),
                  authService.loginR.proid.toString());
              CupertinoAlertDialog(
                content: Text('Usuario modificado correctamente'),
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Modificar',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
