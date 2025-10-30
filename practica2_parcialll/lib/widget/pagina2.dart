import 'package:flutter/material.dart';   
class pagina2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Disenio2();
  }
}
class Disenio2 extends State<pagina2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 2'),
      ),
    );
  }
}