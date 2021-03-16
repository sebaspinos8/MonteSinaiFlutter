//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'package:montesinaiweb/methods/methods.dart';
import 'package:montesinaiweb/model/cita_model.dart';
import 'package:montesinaiweb/pages/cita/citas_Agregar_paciente.dart';
import 'package:montesinaiweb/services/auth_service.dart';
import 'package:montesinaiweb/services/cita_service.dart';
import 'package:montesinaiweb/services/sucursalU_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};

class CitasPage extends StatefulWidget {
  static final String routeName = 'Citas';
  CitasPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CitasPageState createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  List<CitaModel> citas = [];
  Methods metodos = new Methods();

  @override
  void initState() {
    final _selectedDay = DateTime.now();
    _events = {};
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTask().then((val) => setState(() {
            _events = val;
          }));
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    if (mounted) {
      setState(() {
        _selectedEvents = events;
      });
    }
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas'),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CitaPacientePage()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue[400],
        todayColor: Colors.blue[200],
        markersColor: Colors.blue[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.blue[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.blue[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.deepOrange[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    //final dateTime = _events.keys.elementAt(_events.length - 2);
    final dateTime = DateTime.now();
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Mes'),
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _calendarController.setCalendarFormat(CalendarFormat.month);
                  });
                }
              },
            ),
            RaisedButton(
              child: Text('2 semanas'),
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _calendarController
                        .setCalendarFormat(CalendarFormat.twoWeeks);
                  });
                }
              },
            ),
            RaisedButton(
              child: Text('Semana'),
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _calendarController.setCalendarFormat(CalendarFormat.week);
                  });
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text(
              'Dia Actual ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8, color: Colors.blue[800]),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: ListTile(
                    leading: Icon(Icons.calendar_today,
                        color: Colors.blue, size: 40),
                    title: Row(
                      children: [
                        Text(
                          'Nombre: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          event.toString().split(':')[0],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(children: [
                          Text(
                            'Hora: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            event.toString().split(':')[6] +
                                ":" +
                                event.toString().split(':')[7],
                          ),
                        ]),
                        SizedBox(
                          height: 3,
                        ),
                        Row(children: [
                          Text(
                            'Asunto: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            event.toString().split(':')[1],
                          ),
                        ]),
                      ],
                    ),
                    onTap: () {
                      print('$event tapped!');
                    }),
              ))
          .toList(),
    );
  }

  Future _cargarCitas() async {
    final citaService = Provider.of<CitaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);

    this.citas = await citaService.listarCita(
        '0',
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString());
    _events = {};

    for (int i = 0; i < citas.length; i++) {
      var parseTime = DateTime.parse(citas[i].fecha.substring(0, 9));
      _events[parseTime] = [citas[i].asunto];
    }
  }

  Future<Map<DateTime, List>> getTask() async {
    Map<DateTime, List> mapFetch = Map<DateTime, List>();
    final citaService = Provider.of<CitaService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final sucursalService =
        Provider.of<SucursalUService>(context, listen: false);
    this.citas = await citaService.listarCita(
        '0',
        authService.loginR.proid.toString(),
        sucursalService.sucursalR.sucid.toString());
    if (citas != null) {
      for (int i = 0; i < citas.length; i++) {
        var parseTime = DateTime.parse(citas[i].fecha.substring(0, 10));
        if (mapFetch[parseTime] != null) {
          mapFetch[parseTime].add(citas[i].nombre +
              ':' +
              citas[i].asunto +
              ':' +
              citas[i].id.toString() +
              ':' +
              citas[i].fecha +
              ':' +
              citas[i].hora);
        } else {
          mapFetch[parseTime] = [
            citas[i].nombre +
                ':' +
                citas[i].asunto +
                ':' +
                citas[i].id.toString() +
                ':' +
                citas[i].fecha +
                ':' +
                citas[i].hora
          ];
        }
      }
    }

    return mapFetch;
  }
}
