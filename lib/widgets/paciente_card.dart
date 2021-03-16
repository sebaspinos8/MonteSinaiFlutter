import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PacienteCard extends StatelessWidget {
  String id;
  String perid = '';
  String proid = '';
  String nombre = '';
  String ident = '';
  String mail = '';
  String edad = '';
  String direccion = '';
  String sucid = '';

  PacienteCard({
    this.id,
    this.perid,
    this.proid,
    this.nombre,
    this.ident,
    this.mail,
    this.edad,
    this.direccion,
    this.sucid,
  });

  Random _random = new Random();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 128,
      child: Stack(
        children: [
          Container(
            // height: 200,
            margin: EdgeInsets.only(
              top: 10,
              bottom: 2,
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 70,
                  child: Image(image: AssetImage('assets/mask.png')),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              this.nombre,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700]),
                            ),
                          ],
                        ),
                        Row(children: [
                          Text(
                            'DIRECCION: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            this.direccion,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            'EDAD: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            edad + ' años',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            'MAIL: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            this.mail,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
