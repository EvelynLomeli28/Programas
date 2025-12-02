import 'package:app3_unidad4/basededatos/basededatoshelper.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}
class Clase extends State<Pagina1>{
bool ventana = false;
void _MostrarDatos(String numeros){
  TextEditingController nombre = TextEditingController();
  TextEditingController precio = TextEditingController();
   showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("El codido ${numeros}",style: TextStyle(fontSize: 15),),
                TextField(
                  controller: nombre,
                  decoration: InputDecoration(
                    labelText: 'Escribe el nombre del producto'
                  ),
                ),
                TextField(
                  controller: precio,
                  decoration: InputDecoration(
                    labelText: 'Escribe el precio'
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                await Basedatoshelper().insertar(numeros, nombre.text, precio.text);
                 //cargarDatos();
                 Navigator.pop(context);
              }, 
              child: Text('Guardar'),
              ),
              TextButton(
              onPressed: ()=>Navigator.pop(context),
              child: Text('Cancelar'),
              ),
          ],
        );
      }
      );
}
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text('QR con SQFlite'),
      backgroundColor: Colors.orange,
    ),
      body: MobileScanner(
      onDetect: (capture) {
       // print("¡Detectado!");
       if(!ventana){
        final barcode = capture.barcodes.first;
        final numeros= barcode.rawValue ?? 'Sin codigo';
        //print("QR: ${numeros}");
        if (numeros != 'Sin codigo'){
          _MostrarDatos(numeros);
          ventana = true;
        }
       }
      },
    ),
   );
  }

}