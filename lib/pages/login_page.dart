import 'package:montesinaiweb/model/login_model.dart';

import 'package:montesinaiweb/pages/sucursal/sucursal_page.dart';
import 'package:montesinaiweb/services/auth_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = 'Login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

final userCtrl = TextEditingController();
final passCtrl = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  static String usuarioG = "";
  static String passG = "";

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_crearFondo(context), _uiSetup(context)],
      ),
      /*  child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,*/
    );
  }

  Widget _uiSetup(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 50.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      //efecto sombra
                      offset: Offset(0.0, 10.0),
                      spreadRadius: 3.0)
                ]),
            child: Form(
              key: globalFormKey,
              child: Column(
                children: <Widget>[
                  new TextFormField(
                    style: TextStyle(fontSize: 20),
                    onSaved: (input) => usuarioG = input,
                    decoration: new InputDecoration(
                      hintText: "Usuario",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 20),
                    keyboardType: TextInputType.text,
                    onSaved: (input) => passG = input,
                    validator: (input) => input.length < 3
                        ? "LA CONTRASEÑA DEBE TENER MAS DE 3 CARACTERES"
                        : null,
                    obscureText: hidePassword,
                    decoration: new InputDecoration(
                      hintText: "Contraseña",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).accentColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          }
                        },
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                    onPressed: () {
                      if (true) {
                        if (validateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                        }

                        var apiService =
                            Provider.of<AuthService>(context, listen: false);
                        apiService.login(usuarioG, passG).then((value) {
                          if (value != null) {
                            if (mounted) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                            }

                            if (value.proid > 0) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SucursalPage()));
                            } else if (value.proid == 0) {
                              final alert = AlertDialog(
                                  content: Text(
                                      "Contraseña incorrecta, vuelva a ingresar",
                                      style:
                                          TextStyle(color: Colors.blue[800])));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            } else {
                              final alert = AlertDialog(
                                  content: Text(
                                      "El usuario no existe, compruebe sus credenciales",
                                      style:
                                          TextStyle(color: Colors.blue[800])));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          }
                        });
                      }
                    },
                    child: Text(
                      "Ingresar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                  ),
                  SizedBox(height: 0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

Widget _crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;

  final fondoverde = Container(
    height: size.height * 0.4,
    width: double.infinity,
    //color: Color.fromRGBO(23, 143, 183, 1.0),
    foregroundDecoration:
        BoxDecoration(color: Color.fromRGBO(23, 143, 183, 1.0)),
  );

//circulos blacos
  final circulo = Container(
    width: 35.0,
    height: 35.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromRGBO(255, 255, 255, 0.5)),
  );

//circulos azules
  final circulo1 = Container(
    width: 35.0,
    height: 35.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromRGBO(60, 150, 205, 0.5)),
  );

//circulos morados
  final circulo2 = Container(
    width: 35.0,
    height: 35.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromRGBO(140, 150, 205, 0.5)),
  );

  //circulos verdes
  final circulo3 = Container(
    width: 35.0,
    height: 35.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromRGBO(0, 140, 105, 0.5)),
  );

  return Stack(
    children: <Widget>[
      fondoverde,
      Positioned(top: 120.0, left: 90.0, child: circulo),
      Positioned(top: 160.0, left: 50.0, child: circulo1),
      Positioned(top: 80.0, left: 50.0, child: circulo2),
      Positioned(top: 120.0, left: 10.0, child: circulo3),

      Positioned(top: 120.0, right: 90.0, child: circulo),
      Positioned(top: 160.0, right: 50.0, child: circulo1),
      Positioned(top: 80.0, right: 50.0, child: circulo2),
      Positioned(top: 120.0, right: 10.0, child: circulo3),

      //fondo blanco / parte inferior cuadros

      Positioned(bottom: 70.0, right: -10.0, child: circulo1),
      Positioned(bottom: 120.0, right: 20.0, child: circulo2),
      Positioned(bottom: 30.0, right: 40.0, child: circulo3),

      Positioned(bottom: 80.0, left: 10.0, child: circulo2),
      Positioned(bottom: 120.0, left: 30.0, child: circulo3),
      Positioned(bottom: 50.0, left: 60.0, child: circulo1),

      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            Icon(Icons.medical_services_outlined,
                color: Colors.white, size: 100.0),
            SizedBox(height: 1.0, width: double.infinity),
            Text('Nombre de la app',
                style: TextStyle(color: Colors.white, fontSize: 35.0))
          ],
        ),
      )
    ],
  );
}
