// ignore_for_file: use_key_in_widget_constructors, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

//https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e

//This app makes use of the Row, Column,
//Expanded, Padding, Transform, Container,
//BoxDecoration, BoxShape, Colors,
//Border, Center, Align, Alignment,
//EdgeInsets, Text, and TextStyle Widgets
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //first level widget of Material Design
      home: Scaffold(
        //default route
        backgroundColor: Color.fromARGB(255, 220, 227, 232),
        appBar: AppBar(
          title: const Text("Currency Exchange", style: TextStyle(color:  Color.fromARGB(255, 216, 231, 243)),),
          
          backgroundColor: Color.fromARGB(255, 1, 108, 111),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('Favourites', 
                  style: TextStyle(
                      color:  Color.fromARGB(255, 8, 69, 71), 
                      fontSize: 25
                    )
                ),
          ],
        ),
      ),
    );
  }
}
