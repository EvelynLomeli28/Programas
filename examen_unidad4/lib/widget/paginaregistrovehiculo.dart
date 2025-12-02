
import 'package:examen_unidad4/basededatos/basededatoshelper.dart';
import 'package:flutter/material.dart';


class PaginaRegistroVehiculo extends StatefulWidget {
const PaginaRegistroVehiculo({super.key});
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}
class Clase extends State<PaginaRegistroVehiculo>{
 

  @override
  Widget build(BuildContext context) {
    TextEditingController marca = TextEditingController();
    TextEditingController modelo = TextEditingController(); 
    TextEditingController precio = TextEditingController();
    Future<void> Guardar() async {
      String m = marca.text;
      String mo = modelo.text;
      String p = precio.text;
      String c = '';

      if (m.isNotEmpty && mo.isNotEmpty && p.isNotEmpty){
        await Basedatoshelper().insertar(m,mo,p,c);
        print("Usuario agregado");
        marca.clear();
        modelo.clear();
        precio.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Vehiculo Agregado")),
          );
      }else{
        print("Error");
      }
      }
      String? _vprecio(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe numero';
      }
      if ((value.length <6 || value.length > 12)){
        return 'El precio debe tener entre 6 y 12 digitos';
      }
       final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo datos validos';
      }
      return null;
    }
      String? _vmodelo(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe el modelo';
      }
      if ((value.length <4 || value.length > 5)){
        return 'El modelo debe tener entre 4 y 5 digitos';
      }
       final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa datos validos';
      }
      return null;
    }
      String? _vmarca(String? value){
      if(value== null || value.isEmpty){
        return 'Escribe la marca';
      }
        final nom = RegExp(r'^[a-z]+$');
      if(!nom.hasMatch(value)){
            return 'Error solo minusculas';
      }
      return null;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Registrar Vehículo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Datos del Vehículo",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      ),                
                  SizedBox(height: 20),
                  TextFormField(
                    validator: _vmarca,
                    controller: marca,
                    decoration: InputDecoration(
                      labelText: "Marca",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: modelo,
                    validator: _vmodelo,
                    decoration: InputDecoration(
                      labelText: "Modelo",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: _vprecio,
                    controller: precio,
                    decoration: InputDecoration(
                      labelText: "Precio",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: Guardar,
                    child: Text("Guardar Vehículo"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}