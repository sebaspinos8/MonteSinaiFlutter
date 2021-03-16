import 'package:montesinaiweb/model/cita_model.dart';
import 'package:montesinaiweb/model/ficha_model.dart';
import 'package:montesinaiweb/pages/cita/citas_Agregar.dart';
import 'package:montesinaiweb/pages/paciente/pacientes_Agregar.dart';
import 'package:montesinaiweb/pages/paciente/pacientes_Modificar.dart';

import 'package:montesinaiweb/services/auth_service.dart';
import 'package:montesinaiweb/services/ficha_service.dart';
import 'package:montesinaiweb/services/paciente_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';

import '../../model/paciente_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../widgets/paciente_card.dart';
import '../../methods/methods.dart';

class CitaPacientePage extends StatefulWidget {
  static final String routeName = 'CitaPacientes';

  CitaPacientePage({Key key}) : super(key: key);
  @override
  _CitaPacientePageState createState() => _CitaPacientePageState();
}

class _CitaPacientePageState extends State<CitaPacientePage> {
  PacienteService pacienteService = new PacienteService();
  Methods metodos = new Methods();
  TextEditingController controller = new TextEditingController();
  List<bool> isSelected = [true, false];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<PacienteModel> pacientes = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this._cargarPacienteActivo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(
              "Pacientes",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              // style: TextStyle(color: Colors.black87),
            ),
            elevation: 40,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PacientesAgregarPage()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueAccent),
        body: _listaPaciente());
  }

  SmartRefresher _listaPaciente() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _cargarPacienteActivo,
      header: WaterDropHeader(
        complete: Icon(
          Icons.check,
          color: Colors.lightBlueAccent,
        ),
        waterDropColor: Colors.blueAccent[400],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: _buildSearchBox(isSelected[0])),
              ToggleButtons(
                borderRadius: BorderRadius.circular(30),
                fillColor: isSelected[1] ? Colors.redAccent : Colors.blueAccent,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 80,
                    child: Icon(
                      Icons.person,
                      color: isSelected[0] ? Colors.white : Colors.blueAccent,
                      size: 30,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    child: Icon(
                      Icons.delete,
                      color: isSelected[1] ? Colors.white : Colors.redAccent,
                      size: 30,
                    ),
                  ),
                ],
                onPressed: (int index) {
                  //Se muestran pacientes activos o inactivos
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = !isSelected[buttonIndex];
                        if (isSelected[0]) {
                          if (mounted) {
                            setState(() {
                              pacientes = [];
                              _cargarPacienteActivo();
                              _listaPaciente();
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              pacientes = [];
                              _cargarPacienteInactivo();
                              _listaPaciente();
                            });
                          }
                        }
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: this.pacientes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  //Dismissable es el que deslizas para eliminar o editar, las funciones estan en confirmDismiss, el arreglo isSlected tiene dos booleanos para saber si es que presiono uno de los dos botones
                  confirmDismiss: (direction) async {
                    if (isSelected[0] == true) {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                  "Esta seguro que desea eliminar a ${pacientes[index].nombre}?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "Eliminar",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _eliminarPaciente('0',
                                            pacientes[index].id.toString());
                                        _listaPaciente();
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      } else {
                        //Se llama al metodo de consulta para editar ese paciente en la ventana nueva
                        final pacienteuService = Provider.of<PacienteService>(
                            context,
                            listen: false);
                        pacienteuService
                            .consultaPaciente(
                                this.pacientes[index].proid.toString(),
                                this.pacientes[index].id.toString())
                            .then((value) {
                          Future.delayed(Duration(milliseconds: 50), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PacientesModificarPage()));
                          });
                        });
                      }
                    } else {
                      setState(() {
                        _eliminarPaciente('1', pacientes[index].id.toString());
                        _listaPaciente();
                      });
                    }
                  },
                  direction: isSelected[0]
                      ? DismissDirection.horizontal
                      : DismissDirection.startToEnd,
                  background: isSelected[0]
                      ? slideRightBackground()
                      : slideLeftBackground(isSelected),
                  secondaryBackground: slideLeftBackground(isSelected),
                  key: Key(this.pacientes[index].id.toString()),
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: PacienteCard(
                          id: this.pacientes[index].id.toString(),
                          perid: this.pacientes[index].perid.toString(),
                          proid: this.pacientes[index].proid.toString(),
                          nombre: this.pacientes[index].nombre,
                          ident: this.pacientes[index].ident,
                          mail: this.pacientes[index].mail,
                          edad: metodos
                              .funcionEdad(this.pacientes[index].fechanac),
                          direccion: this.pacientes[index].direccion,
                          sucid: this.pacientes[index].sucid.toString()),
                    ),
                    onTap: () {
                      //Se abre el listado del paciente elegido
                      CitaModel citaModel = new CitaModel();

                      final pacienteuService =
                          Provider.of<PacienteService>(context, listen: false);
                      pacienteuService
                          .consultaPaciente(
                              this.pacientes[index].proid.toString(),
                              this.pacientes[index].id.toString())
                          .then((value) {
                        Future.delayed(const Duration(milliseconds: 200), () {
                          citaModel.proid = value.proid;
                          citaModel.sucid = value.sucid;
                          citaModel.pacid = this.pacientes[index].id;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CitasAgregarPage(citas: citaModel)));
                        });
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _cargarBusquedaPacienteActivo(String nombre) async {
    String buscada = nombre.toUpperCase();
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);

    this.pacientes = await pacienteService.consultaPacienteNombre(
        "0",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString(),
        buscada);
    if (mounted) {
      setState(() {
        _listaPaciente();
      });
    }
    _refreshController.refreshCompleted();
  }

  _cargarBusquedaPacienteInactivo(String nombre) async {
    String buscada = nombre.toUpperCase();
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);

    this.pacientes = await pacienteService.consultaPacienteNombre(
        "1",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString(),
        buscada);
    if (mounted) {
      setState(() {
        _listaPaciente();
      });
    }
    _refreshController.refreshCompleted();
  }

  _cargarPacienteActivo() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);

    this.pacientes = await pacienteService.listarPaciente(
        "0",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString());

    if (mounted) {
      setState(() {
        _listaPaciente();
      });
    }
    _refreshController.refreshCompleted();
  }

  _cargarPacienteInactivo() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);

    this.pacientes = await pacienteService.listarPaciente(
        "1",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString());

    if (mounted) {
      setState(() {
        _listaPaciente();
      });
    }
    _refreshController.refreshCompleted();
  }

  _cargarUltimaFicha(String id) async {
    final fichaService = Provider.of<FichaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final pacienteService =
        Provider.of<PacienteService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);
    final resp = await fichaService.ultimaFichaPaciente(
        authService.loginR.proid.toString(),
        id,
        sucursalService.sucursalR.sucid.toString());

    if (mounted) {
      setState(() {
        //_listaPaciente();
      });
    }
  }

  _eliminarPaciente(String opcion, String id) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    String resp = await pacienteService.eliminarPaciente(
        authService.loginR.proid.toString(), id, opcion);
    if (opcion == '1') {
      if (mounted) {
        setState(() {
          _cargarPacienteInactivo();
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _cargarPacienteActivo();
        });
      }
    }
  }

  Widget slideRightBackground() {
    //Lo que pasa cuando deliza a la derecha el card
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.create,
              color: Colors.white,
              size: 30,
            ),
            Text(
              "  Editar",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideLeftBackground(List<bool> arreglo) {
    //LO que pasa cuando desliza a la izquierda
    if (arreglo[0] == true) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Eliminar  ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 35,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.undo_sharp,
                color: Colors.white,
                size: 30,
              ),
              Text(
                "  Restablecer",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
        ),
      );
    }
  }

  Widget _buildSearchBox(bool resp) {
    return new TextField(
      controller: controller,
      decoration: new InputDecoration(hintText: 'Buscar por nombre'),
      onChanged: resp
          ? _cargarBusquedaPacienteActivo
          : _cargarBusquedaPacienteInactivo,
    );
  }
}
