import 'package:flutter/material.dart';

class Pagina extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Disenio();
  }
}
class Disenio extends State<Pagina>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practica 1 Unidad 4'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Padding(padding: EdgeInsetsGeometry.all(10),
        child: Card(
          elevation: 18,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize:MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: Text('Isuario')
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: Text('Password')
                    ),
                  )
                ],
            ),
          ),
        ),),
      ),
    );
  }
}
