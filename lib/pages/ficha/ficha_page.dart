import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/model/ficha_model.dart';

import 'package:montesinaiweb/services/auth_service.dart';
import 'package:montesinaiweb/services/ficha_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ficha_Agregar_paciente.dart';
import 'ficha_Modificar_page2.dart';
import 'ficha_detail.dart';

class FichaPage extends StatefulWidget {
  static final String routeName = 'Fichas';

  FichaPage({Key key}) : super(key: key);
  @override
  _FichaPageState createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  Methods metodos = new Methods();
  List<bool> isSelected = [true, false];
  TextEditingController controllerT = new TextEditingController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<FichaModel> fichas = [];
  List<Widget> itemsData = [];
  ScrollController controller = ScrollController();
  double topContainer = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this._cargarFichaActiva();
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
              "Fichas",
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
                MaterialPageRoute(builder: (context) => FichaPacientePage()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueAccent),
        body: _listaFicha());
  }

  SmartRefresher _listaFicha() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _cargarFichaActiva,
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
                    width: 40,
                    child: Icon(
                      Icons.person,
                      color: isSelected[0] ? Colors.white : Colors.blueAccent,
                      size: 30,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
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
                              fichas = [];
                              _cargarFichaActiva();
                              _listaFicha();
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              fichas = [];
                              _cargarFichaInactiva();
                              _listaFicha();
                            });
                          }
                        }
                      } else {
                        isSelected[buttonIndex] = !isSelected[buttonIndex];
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              controller: controller,
              physics: BouncingScrollPhysics(),
              itemCount: this.fichas.length,
              itemBuilder: (context, index) {
                if (this.fichas.length != 0) {
                  double scale = 1.0;
                  if (topContainer > 0.5) {
                    scale = index + 0.5 - topContainer;
                    if (scale < 0) {
                      scale = 0;
                    } else if (scale > 1) {
                      scale = 1;
                    }
                  }
                  return Opacity(
                    opacity: scale,
                    child: Transform(
                      transform: Matrix4.identity()..scale(scale, scale),
                      alignment: Alignment.bottomCenter,
                      child: Align(
                        heightFactor: 0.7,
                        alignment: Alignment.topCenter,
                        child: Dismissible(
                          confirmDismiss: (direction) async {
                            if (isSelected[0] == true) {
                              if (direction == DismissDirection.endToStart) {
                                final bool res = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                          "Esta seguro que desea eliminar la ficha de ${fichas[index].nombre}?",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              "Cancelar",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              "Eliminar",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _eliminarFicha(
                                                    '0',
                                                    fichas[index]
                                                        .id
                                                        .toString());
                                                _listaFicha();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                return res;
                              } else {
                                final fichaService = Provider.of<FichaService>(
                                    context,
                                    listen: false);
                                fichaService
                                    .consultaFicha(
                                        this.fichas[index].id.toString())
                                    .then((value) {
                                  Future.delayed(Duration(milliseconds: 50),
                                      () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FichaModificar2Page()));
                                  });
                                });
                              }
                            } else {
                              setState(() {
                                _eliminarFicha(
                                    '1', fichas[index].id.toString());
                                _listaFicha();
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
                          key: Key(this.fichas[index].id.toString()),
                          child: InkWell(
                              child: Container(
                                  height: 180,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                      gradient: new LinearGradient(stops: [
                                        0.05,
                                        0.05
                                      ], colors: [
                                        Colors.blueAccent,
                                        Colors.white
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withAlpha(200),
                                            blurRadius: 10.0),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 100,
                                                ),
                                                Text(
                                                  this.fichas[index].nombre,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.blue[700],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(children: [
                                                  Text(('• EDAD: '),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      metodos.funcionEdad(this
                                                              .fichas[index]
                                                              .fechanac) +
                                                          ' años',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ]),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(children: [
                                                  Text('• FECHA DE CREACION:',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                    metodos.formatoFecha(this
                                                        .fichas[index]
                                                        .fecha
                                                        .substring(0, 10)
                                                        .replaceAll('-', '/')),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  )
                                                ]),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(children: [
                                                  Text('• DIAGNOSTICO: ',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                    this
                                                                .fichas[index]
                                                                .diagnostico
                                                                .length >
                                                            20
                                                        ? this
                                                                .fichas[index]
                                                                .diagnostico
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : this
                                                            .fichas[index]
                                                            .diagnostico,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black),
                                                  ),
                                                ]),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(children: [
                                                  Text('• EVOLUCION:',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                    this
                                                                .fichas[index]
                                                                .evolucion
                                                                .length >
                                                            20
                                                        ? this
                                                                .fichas[index]
                                                                .evolucion
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : this
                                                            .fichas[index]
                                                            .evolucion,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black),
                                                  )
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          height: 80,
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/ficha2.png')),
                                        ),
                                      ],
                                    ),
                                  )),
                              onTap: () {
                                final fichaService = Provider.of<FichaService>(
                                    context,
                                    listen: false);
                                fichaService
                                    .consultaFicha(
                                        this.fichas[index].id.toString())
                                    .then((value) {
                                  Future.delayed(
                                      const Duration(milliseconds: 200), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FichaDetailPage()));
                                  });
                                });
                              }),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _cargarFichaActiva() async {
    final fichaService = Provider.of<FichaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);
    this.fichas = await fichaService.listarFicha(
        "0",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString());

    if (mounted) {
      setState(() {
        _listaFicha();
      });
    }
    _refreshController.refreshCompleted();
  }

  _cargarFichaInactiva() async {
    final fichaService = Provider.of<FichaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);
    this.fichas = await fichaService.listarFicha(
        "1",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString());

    if (mounted) {
      setState(() {
        _listaFicha();
      });
    }
    _refreshController.refreshCompleted();
  }

  Widget slideRightBackground() {
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

  _eliminarFicha(String opcion, String id) async {
    final fichaService = Provider.of<FichaService>(context, listen: false);
    String resp = await fichaService.eliminarFicha(id, opcion);
    if (opcion == '1') {
      if (mounted) {
        setState(() {
          _cargarFichaActiva();
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _cargarFichaInactiva();
        });
      }
    }
  }

  _cargarBusquedaFichaActivo(String nombre) async {
    String buscada = nombre.toUpperCase();
    final fichaService = Provider.of<FichaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);

    this.fichas = await fichaService.consultaFichaNombre(
        "0",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString(),
        buscada);
    if (mounted) {
      setState(() {
        _listaFicha();
      });
    }

    _refreshController.refreshCompleted();
  }

  _cargarBusquedaFichaInactivo(String nombre) async {
    String buscada = nombre.toUpperCase();
    final fichaService = Provider.of<FichaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);

    this.fichas = await fichaService.consultaFichaNombre(
        "1",
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString(),
        buscada);
    if (mounted) {
      setState(() {
        _listaFicha();
      });
    }

    _refreshController.refreshCompleted();
  }

  Widget _buildSearchBox(bool resp) {
    return new TextField(
      controller: controllerT,
      decoration: new InputDecoration(hintText: 'Buscar por nombre'),
      onChanged:
          resp ? _cargarBusquedaFichaActivo : _cargarBusquedaFichaInactivo,
    );
  }
}
