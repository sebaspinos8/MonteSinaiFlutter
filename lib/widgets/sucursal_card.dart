import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SucursalCard extends StatelessWidget {
  String id;
  String perid = '';
  String proid = '';
  String nombre = '';
  String descripcion = '';
  String direccion = '';
  String sucid = '';

  SucursalCard({
    this.id,
    this.perid,
    this.proid,
    this.nombre,
    this.direccion,
    this.sucid,
  });

  final colors = [
    Colors.blueGrey[200],
    Colors.green[200],
    Colors.pink[100],
    Colors.brown[200],
    Colors.lightBlue[200],
  ];

  Random _random = new Random();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final randomColor = colors[_random.nextInt(colors.length)];
    return GestureDetector(
      onTap: () {
        /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                id: this.id,
                color: randomColor,
              );
            },
          ),
        );*/
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 240,
        child: Stack(
          children: [
            Container(
              // height: 200,
              margin: EdgeInsets.only(
                top: 50,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.32,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                this.nombre,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'DIRECCION: ' + this.direccion,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Descripcion ' + descripcion + ' años',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        
                        ],
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              width: size.width * 0.30,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    margin: EdgeInsets.only(top: 35),
                  ),
                  Align(
                    child: Icon(Icons.person),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
