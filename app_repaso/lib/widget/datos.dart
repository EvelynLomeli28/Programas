import 'package:app_repaso/widget/lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Datos extends StatefulWidget{
  const Datos({super.key});

  @override
  State<StatefulWidget> createState() {
    return _datos();
  }
}
class Item{
  final String nom;
  final String c1;
  final String c2;
  final String c3;
  Item(this.nom,this.c1, this.c2, this.c3);
}
class _datos extends State<Datos>{
  final _llave = GlobalKey<FormState>();
  final TextEditingController nombre = TextEditingController();
  final TextEditingController calif1 = TextEditingController();
  final TextEditingController calif2 = TextEditingController();
  final TextEditingController calif3 = TextEditingController();
  List<Item>items=[];

  void _enviar()async{
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Lista(
        items: items,
      )
      )
      );
      setState(() {
      });
  }
  void _guardar(){
    setState(() {
      String n = nombre.text;
      String ca1 = calif1.text;
      String ca2 = calif2.text;
      String ca3 = calif3.text;
      if(n.isNotEmpty || ca1.isNotEmpty|| ca2.isNotEmpty|| ca3.isNotEmpty){
        items.add(Item(n, ca1, ca2, ca3));
        nombre.clear();
        calif1.clear();
        calif2.clear();
        calif3.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Datos agregados"))
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Faltan datos"))
        );
      }
    });
  }
  String? _vcal1(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe numero';
      }
      final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo numeros';
      }
      return null;
    }
    String? _vcal2(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe numero';
      }
      final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo numeros';
      }
      return null;
    }
    String? _vcal3(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe numero';
      }
      final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo numeros';
      }
      return null;
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de Estudiantes'),
        backgroundColor: const Color.fromARGB(255, 183, 58, 79),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enviar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(padding: EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
              key: _llave,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                    ),
                    TextFormField(
                      controller: nombre,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre Completo',
                      ) ,
                      keyboardType: TextInputType.name
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: calif1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Calificacion 1',
                      ) ,
                      validator: _vcal1,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: calif2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Calificacion 2',
                      ) ,
                      validator: _vcal2,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: calif3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Calificacion 3',
                      ) ,
                      validator: _vcal3,
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                      onPressed: _guardar,
                      child: Text('Guardar Datos',
                      style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 183, 58, 79),),
                    ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }
}