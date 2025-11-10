import 'package:flutter/material.dart';
class Detalles extends StatefulWidget{
  final String clave;
  final String nombre;
  final String correo;
  const Detalles({super.key,required this.clave,required this.nombre,required this.correo});
  @override
  State<StatefulWidget> createState() {
    return Clase();}}
class Clase extends State<Detalles>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
        backgroundColor: const Color.fromARGB(255, 183, 58, 93),), 
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 18,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    height: 190,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage('https://i.pinimg.com/236x/05/2c/9d/052c9da2359097380765b6e792231e30.jpg'),),),
                  SizedBox(
                    height: 40,),
                  SizedBox(
                    child: 
                    Text('${widget.clave}',style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 112, 11, 44)),),),
                  SizedBox(
                    height: 15,),
                  SizedBox(
                    child: 
                    Text('${widget.nombre}',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 14, 99, 79)),),),
                  SizedBox(height: 10,),
                  SizedBox(
                    child: 
                    Text('${widget.correo}',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 8, 45, 71)
                  ),),),],),),),),),);}
}