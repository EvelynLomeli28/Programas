import 'dart:math';

import 'package:examen_listasp3evelyn/widget/Pagina2.dart';
import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget{
  const Pagina1({super.key});

  @override
  State<StatefulWidget> createState() {
    return Disenio();
  }
}
class Disenio extends State<Pagina1>{
  final _llave = GlobalKey<FormState>();
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController genero = TextEditingController();


  void registrar(){
    String non = nombre.text;
    String cor = correo.text;
    String tel = telefono.text;
    String gen = genero.text;
    int num = Random().nextInt(200);
    if (_llave.currentState?.validate() ?? false){
      final String clave = num.toString()+ non.substring(0,2).toUpperCase(); 
           Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => Pagina2(
                n: non,
                c: cor,
                t: tel,
                g: gen,
                cl: clave,
              ),
            ),
            );
     }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, Completa los datos')),
        );

     }
  }
  String? _vnombre(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe un nombre';
      }
      final exp = RegExp(r'^[A-Z\s ]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo letras mayusculas';
      }
      return null;
    }
    String? _vcorreo(String? value) {
      if (value == null || value.isEmpty) {
        return 'Ingresa un correo electrónico';
      }
      final exp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');
      if (!exp.hasMatch(value)) {
        return 'Ingresa un correo electrónico válido';
      }
      return null;
    }
    String? _vtelefono(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe numero';
      }
      if ((value.length > 10)){
        return 'El numero telefonico solo debe tener 10 digitos';
      }
       final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo numeros';
      }
      return null;
    }
    String? _vgenero(String? value) {
      if (value == null || value.isEmpty) {
        return 'Ingresa tu sexo (F o H)';
      }

      final exp = RegExp(r'^[FfHh]$');
      if (!exp.hasMatch(value)) {
        return 'Sólo se permite F o H';
      }
      return null;

      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuarios',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Padding(padding: EdgeInsetsGeometry.all(12),
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
          ),
          child: Form(
            key: _llave,
            child:Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Datos Personales",
                style: TextStyle(
                  color: const Color.fromARGB(169, 33, 11, 176),
                  fontSize: 25,
                  fontFamily: 'Verdana',
                  fontWeight: FontWeight.bold,
                ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Nombre Completo'),
                    border: OutlineInputBorder()
                  ),
                  controller: nombre,
                  validator: _vnombre,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Correo Electronico'),
                    border: OutlineInputBorder(),
                  ),
                  controller: correo,
                  validator: _vcorreo,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label:Text("Telefono"),
                    border: OutlineInputBorder(),
                  ),
                  controller: telefono,
                  validator: _vtelefono,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Genero"),
                    border: OutlineInputBorder(),
                  ),
                  controller: genero,
                  validator: _vgenero,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: registrar, 
                    child: Text("Registrar"),
                  ),
                )
              ],
            ),
          )
          ),
        ),
        ),
      ),
    );
  }
}