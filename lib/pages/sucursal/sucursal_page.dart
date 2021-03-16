import 'package:montesinaiweb/model/sucursal_model.dart';
import 'package:montesinaiweb/services/auth_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:montesinaiweb/services/sucursal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../main.dart';
import '../sucursal/SucursalAgregarPage.dart';

class SucursalPage extends StatefulWidget {
  static final String routeName = 'sucursal';

  @override
  _SucursalPageState createState() => _SucursalPageState();
}

class _SucursalPageState extends State<SucursalPage> {
  SucursalService sucursalService = new SucursalService();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<SucursalModel> sucursales = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this._cargarSucursales();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultorios'),
      ),
      body: _listaSucursales(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(90, 150, 200, 1.0)),
    );
  }

  SmartRefresher _listaSucursales() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _cargarSucursales,
      header: WaterDropHeader(
        complete: Icon(
          Icons.check,
          color: Colors.lightBlueAccent,
        ),
        waterDropColor: Colors.blueAccent[400],
      ),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: this.sucursales.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10.0, //sombreado
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20.0)), //redondeo de card en las esquinas
            child: Column(children: <Widget>[
              ListTile(
                leading: Container(
                  width: 100,
                  height: 70,
                  child: Image(image: AssetImage('assets/hospital.png')),
                ),
                onTap: () {
                  var sucursalUService =
                      Provider.of<SucursalUService>(context, listen: false);
                  sucursalUService
                      .listar(this.sucursales[index].sucid.toString())
                      .then((value) {
                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
                      );
                    });
                  });
                },
                title: Text(this.sucursales[index].nombre),
                subtitle: Text(this.sucursales[index].direccion),
              ),
              FlatButton(
                textColor: Colors.white,
                child: Text('Configurar'),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SucursalAgregarPage()));
                },
              ),
            ]),
          );
        },
      ),
    );
  }

  _cargarSucursales() async {
    final sucursalesService =
        Provider.of<SucursalService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    this.sucursales = await sucursalesService.listar(
        "0", authService.loginR.proid.toString());
    setState(() {
      _listaSucursales();
    });
    _refreshController.refreshCompleted();
  }
}
