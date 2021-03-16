import 'package:montesinaiweb/pages/cita/citas.dart';
import 'package:montesinaiweb/pages/configuracion_perfil.dart';
import 'package:montesinaiweb/pages/ficha/ficha_page.dart';
import 'package:montesinaiweb/pages/paciente/paciente_page.dart';
import 'package:montesinaiweb/services/cita_service.dart';
import 'package:montesinaiweb/services/fichaM_service.dart';
import 'package:montesinaiweb/services/ficha_service.dart';
import 'package:montesinaiweb/services/paciente_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:montesinaiweb/services/sucursal_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

import 'pages/sucursal/sucursal_page.dart';
import 'services/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MultiProvider para el manejo de informacion en toda la app, cada provider tiene su informacion.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => CitaService()),
        ChangeNotifierProvider(create: (context) => FichaService()),
        ChangeNotifierProvider(create: (context) => PacienteService()),
        ChangeNotifierProvider(create: (context) => SucursalService()),
        ChangeNotifierProvider(create: (context) => SucursalUService()),
        ChangeNotifierProvider(create: (context) => FichaMService()),
      ],
      child: MaterialApp(
        title: 'Image Loader',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('es'), // Español
          const Locale.fromSubtags(
              languageCode: 'zh'), // Chinese *See Advanced Locales below*
          // ... other locales the app supports
        ],
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'citas': (BuildContext context) => CitasPage(),
          'fichas': (BuildContext context) => FichaPage(),
          'pacientes': (BuildContext context) => PacientePage(),
          'sucursal': (BuildContext context) => SucursalPage(),
          'configuracion': (BuildContext context) => ConfiguracionPage(),
          'homeprincipal': (BuildContext context) => HomePage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          CitasPage.routeName: (BuildContext context) => CitasPage(),
          FichaPage.routeName: (BuildContext context) => FichaPage(),
          PacientePage.routeName: (BuildContext context) => PacientePage(),
          SucursalPage.routeName: (BuildContext context) => SucursalPage(),
          ConfiguracionPage.routeName: (BuildContext context) =>
              ConfiguracionPage()
          // ConfiguracionPage.routeName: (BuildContext context) =>
          //    ConfiguracionPage()
        },
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  final HomePage _homePage = HomePage();
  final PacientePage _pacientePage = PacientePage();
  final FichaPage _fichaPage = FichaPage();
  final CitasPage _citasPage = CitasPage();
  final ConfiguracionPage _configuracionPage = ConfiguracionPage();

  Widget _firstPage = HomePage();

  Widget _pageEscoger(int page) {
    switch (page) {
      case 0:
        return _homePage;
        break;
      case 1:
        return _pacientePage;
        break;
      case 2:
        return _fichaPage;
        break;
      case 3:
        return _citasPage;
        break;
      case 4:
        return _configuracionPage;
        break;
      default:
        return new Container(
          child: new Text('No page found', style: new TextStyle(fontSize: 30)),
        );
    }
  }

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home_sharp, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
            Icon(Icons.list_alt, size: 30, color: Colors.white),
            Icon(Icons.calendar_today_rounded, size: 30, color: Colors.white),
            Icon(Icons.settings, size: 30, color: Colors.white),
          ],
          color: Colors.blueAccent,
          buttonBackgroundColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            if (mounted) {
              setState(() {
                _firstPage = _pageEscoger(tappedIndex);
              });
            }
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: _firstPage,

            /* child: Column(
              children: <Widget>[
                Text(pageIndex.toString(), textScaleFactor: 10.0),
                RaisedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState.setPage(1);
                  },
                )
              ],
            ),*/
          ),
        ));
  }
}
