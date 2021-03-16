import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/model/ficha_model.dart';
import 'package:montesinaiweb/services/ficha_service.dart';
import 'package:montesinaiweb/services/paciente_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PacienteDetailPage extends StatefulWidget {
  PacienteDetailPage({Key key}) : super(key: key);
  @override
  _PacienteDetailState createState() => _PacienteDetailState();
}

class _PacienteDetailState extends State<PacienteDetailPage> {
  Methods metodos = new Methods();
  FichaModel ultimaFicha = new FichaModel();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //this._cargarUltimaFicha();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pacienteService =
        Provider.of<PacienteService>(context, listen: false);
    final sucursaluService =
        Provider.of<SucursalUService>(context, listen: false);
    final fichaService = Provider.of<FichaService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/doctores.png'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth)),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Image(
                        image: AssetImage('assets/arrow.png'),
                        height: 18,
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .maybePop(context);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.36,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50), bottom: Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.only(top: 25, left: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: CircleAvatar(
                              radius: 30.0,
                              child:
                                  Image.asset('assets/mask.png', height: 100),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pacienteService.pacienteR.nombre,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 21),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'Edad: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 19),
                                  ),
                                  Text(
                                    metodos.funcionEdad(pacienteService
                                            .pacienteR.fechanac) +
                                        ' años',
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 19),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Icon(Icons.credit_card_rounded, color: Colors.white),
                          Text(
                            ' Cedula: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          Text(
                            pacienteService.pacienteR.ident,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.alt_route_rounded, color: Colors.white),
                          Text(
                            ' Direccion: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          Text(
                            pacienteService.pacienteR.direccion,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.phone_rounded, color: Colors.white),
                          Text(
                            ' Telefono: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          Text(
                            pacienteService.pacienteR.nombre,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email_rounded, color: Colors.white),
                          Text(
                            ' Correo: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          Text(
                            pacienteService.pacienteR.mail,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.local_hospital_rounded,
                              color: Colors.white),
                          Text(
                            ' Tratado en: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          Text(
                            sucursaluService.sucursalR.nombre,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Icon(Icons.medical_services_rounded,
                              color: Colors.white),
                          Text(
                            ' Ultima Consulta: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded,
                              color: Colors.white),
                          Text(
                            ' Fecha de Consulta: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          Text(
                            fichaService.fichaR.fecha
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? metodos.formatoFechaDMA(fichaService
                                    .fichaR.fecha
                                    .substring(0, 10)
                                    .replaceAll('-', '/'))
                                : 'No existe consulta previa',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' Ultimo Motivo: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.fichaR.motivo
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.fichaR.diagnostico
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' Ultimo Diagnostico: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.fichaR.diagnostico
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.fichaR.evolucion
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
