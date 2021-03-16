import 'package:montesinaiweb/pages/cita/citas.dart';
import 'package:montesinaiweb/pages/configuracion_perfil.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:montesinaiweb/pages/ficha/ficha_page.dart';
import 'package:montesinaiweb/pages/paciente/paciente_page.dart';

import '../home_page.dart';

class BottomNavBarcitas extends StatefulWidget {
  @override
  _BottomNavBarcitasState createState() => _BottomNavBarcitasState();
}

class _BottomNavBarcitasState extends State<BottomNavBarcitas> {
  int pageIndex = 3;

  final HomePage _homePage = HomePage();
  final PacientePage _pacientePage = PacientePage();
  final FichaPage _fichaPage = FichaPage();
  final CitasPage _citasPage = CitasPage();
  final ConfiguracionPage _configuracionPage = ConfiguracionPage();

  Widget _firstPage = CitasPage();

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
            setState(() {
              _firstPage = _pageEscoger(tappedIndex);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _firstPage,
          ),
        ));
  }
}
