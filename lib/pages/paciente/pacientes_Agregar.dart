import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/pages/bottomNavBar/menubarpacientes.dart';
import 'package:montesinaiweb/services/auth_service.dart';
import 'package:montesinaiweb/services/paciente_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PacientesAgregarPage extends StatefulWidget {
  static final String routeName = 'PacientesA';

  PacientesAgregarPage({Key key}) : super(key: key);

  @override
  _PacientesAgregarPageState createState() => _PacientesAgregarPageState();
}

class _PacientesAgregarPageState extends State<PacientesAgregarPage> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Pacientes"),
        ),
        body: IndexedStack(
          index: 0,
          children: [
            ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: <Widget>[
                  _crearNombre(),
                  Divider(),
                  _crearCedula(),
                  Divider(),
                  _crearCorreo(),
                  Divider(),
                  _crearDireccion(),
                  Divider(),
                  _crearTelefono(),
                  Divider(),
                  _crearFechaNac(context),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
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
            hintText: 'Nombre de la persona',
            labelText: 'Nombre',
            icon: Icon(Icons.account_circle)),
        onChanged: (valor) => setState(() {
              _nombre = valor;
            }));
  }

  Widget _crearDireccion() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Direccion de la persona',
            labelText: 'Direccion',
            icon: Icon(Icons.directions)),
        onChanged: (valor) => setState(() {
              _direccion = valor;
            }));
  }

  Widget _crearTelefono() {
    return TextField(
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Teléfono de la persona',
            labelText: 'Teléfono',
            icon: Icon(Icons.add_call)),
        onChanged: (valor) => setState(() {
              _telefono = valor;
            }));
  }

  Widget _crearCedula() {
    return TextField(
        keyboardType: TextInputType.number,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Ingrese la cedula',
            labelText: 'Cedula',
            icon: Icon(Icons.account_circle)),
        onChanged: (valor) => setState(() {
              _cedula = valor;
            }));
  }

  Widget _crearCorreo() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Email',
            labelText: 'Email',
            suffixIcon: Icon(Icons.alternate_email),
            icon: Icon(Icons.email)),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearFechaNac(BuildContext context) {
    return TextField(
        enableInteractiveSelection: true,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Fecha de nacimiento',
            labelText: 'Fecha de nacimiento',
            suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: Icon(Icons.calendar_today)),
        onTap: () async {
          //FocusScope.of(context).requestFocus(new FocusNode());
          {
            await showDatePicker(
                    context: context,
                    initialDate: new DateTime.now(),
                    firstDate: new DateTime(1950),
                    lastDate: new DateTime(2030),
                    locale: Locale('es', 'ES'))
                .then((picked) {
              if (picked != null) {
                setState(() {
                  print(picked.toString());
                  _inputFieldDateController.text = picked.toString();
                  _fecha = picked.toString();
                });
              }
            });
          }
        });
  }

  _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: new DateTime.now(),
            firstDate: new DateTime(1950),
            lastDate: new DateTime(2030),
            locale: Locale('es', 'ES'))
        .then((picked) {
      if (picked != null) {
        setState(() {
          print(picked.toString());
          _inputFieldDateController.text = picked.toString();
          _fecha = picked.toString();
        });
      }
    });
  }

  Widget botonesGE(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Spacer(),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
            // color: Colors.blue,
            onPressed: () {
              PacienteService pacienteService = new PacienteService();
              AuthService authService =
                  Provider.of<AuthService>(context, listen: false);
              SucursalUService sucursalService =
                  Provider.of<SucursalUService>(context, listen: false);
              Future<String> res = pacienteService.agregarPaciente(
                  '0',
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
                content: Text('Usuario ingresado correctamente'),
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Guardar',
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
