import 'package:montesinaiweb/methods/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:montesinaiweb/model/cita_model.dart';
import 'package:montesinaiweb/pages/bottomNavBar/menubarcitas.dart';
import 'package:montesinaiweb/pages/bottomNavBar/menubarfichas.dart';
import 'package:montesinaiweb/pages/cita/citas.dart';
import 'package:montesinaiweb/services/cita_service.dart';

class CitasAgregarPage extends StatefulWidget {
  static final String routeName = 'PacientesA';
  final CitaModel citas;

  CitasAgregarPage({Key key, this.citas}) : super(key: key);

  @override
  _CitasAgregarPageState createState() => _CitasAgregarPageState();
}

class _CitasAgregarPageState extends State<CitasAgregarPage> {
  String _hora = '';
  String _asunto = '';
  String _fecha = '';
  Methods metodos = new Methods();
  TimeOfDay _time = TimeOfDay.now();

  //conecta  el input fecha con el controlador

  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _inputFieldTimeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Cita"),
        ),
        body: IndexedStack(
          index: 0,
          children: [
            ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: <Widget>[
                  _crearFecha(context),
                  Divider(),
                  _crearHora(context),
                  Divider(),
                  _crearAsunto(),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
                  botonesGE(context)
                ]),
          ],
        ));
  }

  Widget _crearAsunto() {
    return TextField(
        maxLines: 7,
        // autofocus: true,  // marca automaticamente la zona
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Asunto de la Cita',
            labelText: 'Asunto',
            icon: Icon(Icons.article)),
        onChanged: (valor) => setState(() {
              _asunto = valor;
            }));
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
        enableInteractiveSelection: true,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Fecha de la Cita',
            labelText: 'Fecha de la Cita',
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
                  _inputFieldDateController.text = metodos.formatoFechaDMA(
                      picked.toString().substring(0, 10).replaceAll('-', '/'));
                  _fecha = metodos.formatoFechaDMA(
                      picked.toString().substring(0, 10).replaceAll('-', '/'));
                });
              }
            });
          }
        });
  }

  Widget _crearHora(BuildContext context) {
    return TextField(
        enableInteractiveSelection: true,
        controller: _inputFieldTimeController,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Hora de la Cita',
            labelText: 'Hora de la Cita',
            suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: Icon(Icons.calendar_today)),
        onTap: () async {
          //FocusScope.of(context).requestFocus(new FocusNode());
          {
            await showTimePicker(
              context: context,
              initialTime: _time,
            ).then((picked) {
              if (picked != null) {
                setState(() {
                  _inputFieldTimeController.text = picked.format(context);
                  _hora = picked.toString();
                });
              }
            });
          }
        });
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
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
              CitaService citaService = new CitaService();
              Future<String> res = citaService
                  .agregarCita(
                      '0',
                      _fecha,
                      _hora.substring(10, 15),
                      _asunto,
                      widget.citas.pacid.toString(),
                      widget.citas.sucid.toString(),
                      widget.citas.proid.toString())
                  .then((value) {
                CupertinoAlertDialog(
                  content: Text('Cita ingresada correctamente'),
                );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavBarcitas()),
                    ModalRoute.withName("citas"));
              });
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
