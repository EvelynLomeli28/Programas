import 'package:apptarea_unidad4/basededatos/basededatoshelper.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class Mostrar extends StatefulWidget {
  const Mostrar({super.key});
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}
class Clase extends State<Mostrar>{
  List<Map<String, dynamic>> usuarios = [];
  String nombre = "";
  int color1=0;
  int color2=0;
  int color3=0;
  @override
  void initState() {
    super.initState();
    cargarDatos();
  }
  void cargarDatos() async {
    List<Map<String, dynamic>> datos = await Basedatoshelper().obtenerUsuario();
    setState(() {
      usuarios = datos;
    });
    print("Usuarios cargados: ${usuarios.length}");
  }
  void eliminar(int id) async{
     await Basedatoshelper().eliminar(id);
     cargarDatos();
  }
  void _eliminar(int id){
    eliminar(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mostrar datos'),
        backgroundColor: const Color.fromARGB(255, 255, 97, 65),
      ),
      body: usuarios.isEmpty
        ? Center(child: Text('Base de datos vacía'))
        : ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index){
            nombre = usuarios[index]['usuario'][0];
            color1 = Random().nextInt(10)*11;
            color2 = Random().nextInt(10)*5;
            color3 = Random().nextInt(10)*7;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:  Color.fromARGB(color1, color2, color3, 255),
                child: Text(nombre.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                ),
              ),
              title: Text(usuarios[index]['usuario']),
              subtitle: Text(usuarios[index]['password']),
              trailing: IconButton(
                onPressed:(){ 
                  _eliminar(usuarios[index]['id']);
                  }, 
                icon: Icon(Icons.delete),
              ),
            );
          },
        ),
    );
  }
}
