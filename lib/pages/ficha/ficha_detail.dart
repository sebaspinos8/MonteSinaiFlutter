import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/model/ficha_model.dart';
import 'package:montesinaiweb/services/ficha_service.dart';
import 'package:montesinaiweb/services/paciente_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FichaDetailPage extends StatefulWidget {
  FichaDetailPage({Key key}) : super(key: key);
  @override
  _FichaDetailState createState() => _FichaDetailState();
}

class _FichaDetailState extends State<FichaDetailPage> {
  Methods metodos = new Methods();
  FichaModel ultimaFicha = new FichaModel();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
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
                  image: AssetImage('assets/fichas.png'),
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
                            height: 90,
                            width: 90,
                            child: CircleAvatar(
                              radius: 20.0,
                              child:
                                  Image.asset('assets/ficha2.png', height: 70),
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
                                fichaService.ficha.nombre,
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
                                    metodos.funcionEdad(
                                            fichaService.ficha.fechanac) +
                                        ' años',
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 19),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'Fecha de Creación: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    metodos.formatoFechaDMA(fichaService
                                        .ficha.fecha
                                        .substring(0, 10)
                                        .replaceAll('-', '/')),
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Icon(Icons.person_rounded, color: Colors.white),
                          Text(
                            ' Datos Personales: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 21),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.credit_card_rounded, color: Colors.white),
                          Text(
                            ' Cédula: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.ident,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          SizedBox(width: 25),
                          Icon(Icons.phone_rounded, color: Colors.white),
                          Text(
                            ' Teléfono: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.telefono
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? fichaService.ficha.telefono
                                : 'No tiene',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.alt_route_rounded, color: Colors.white),
                          Text(
                            ' Dirección: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.direccion
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? fichaService.ficha.direccion
                                : 'No tiene direccion',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
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
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.mail
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? fichaService.ficha.mail
                                : 'No tiene correo',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
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
                                fontSize: 13),
                          ),
                          Text(
                            sucursaluService.sucursalR.nombre,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Icon(Icons.medical_services_rounded,
                              color: Colors.white),
                          Text(
                            ' Datos Médicos: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 21),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' Motivo de Consulta: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.motivo
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.diagnostico
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' Enfermedad Actual: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.enfermedadActual
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.enfermedadActual
                            : '       No existe',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' Antecedentes Go: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.antGo.toString().compareTo('null') !=
                                0
                            ? fichaService.ficha.antGo
                            : '       No existe',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' Antecedentes Personales y Familiares: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.antPyf
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.antPyf
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' Diagnostico: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.diagnostico
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.diagnostico
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Icon(Icons.medical_services_rounded,
                              color: Colors.white),
                          Text(
                            ' Exámen Físico: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 21),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.linear_scale_rounded, color: Colors.white),
                          Text(
                            ' Pulso: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.pulso
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? fichaService.ficha.pulso
                                : 'N/A',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          SizedBox(width: 25),
                          Icon(Icons.thermostat_outlined, color: Colors.white),
                          Text(
                            ' Temp: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.temp
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? fichaService.ficha.temp
                                : 'N/A',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white),
                          Text(
                            ' PA: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.pa
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? fichaService.ficha.pa
                                : 'N/A',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          SizedBox(width: 40),
                          Icon(Icons.line_weight_rounded, color: Colors.white),
                          Text(
                            ' Peso: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                          Text(
                            fichaService.ficha.peso
                                        .toString()
                                        .compareTo('null') !=
                                    0
                                ? fichaService.ficha.peso
                                : 'N/A',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.ballot_rounded, color: Colors.white),
                          Text(
                            ' Cabeza: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.cabeza
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.cabeza
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.ballot_rounded, color: Colors.white),
                          Text(
                            ' Abdomen: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.abdomen
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.abdomen
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.ballot_rounded, color: Colors.white),
                          Text(
                            ' Extremidades: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.extrem
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.extrem
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.ballot_rounded, color: Colors.white),
                          Text(
                            ' Tórax: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.torax.toString().compareTo('null') !=
                                0
                            ? fichaService.ficha.torax
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.ballot_rounded, color: Colors.white),
                          Text(
                            ' Pelvis: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.pelvis
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.pelvis
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.ballot_rounded, color: Colors.white),
                          Text(
                            ' Tratamiento: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.tratamiento
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.tratamiento
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.ballot_rounded, color: Colors.white),
                          Text(
                            ' Evolución: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        fichaService.ficha.evolucion
                                    .toString()
                                    .compareTo('null') !=
                                0
                            ? fichaService.ficha.evolucion
                            : '       No existe consulta previa',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
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
