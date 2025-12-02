import 'package:apptarea_unidad4/basededatos/basededatoshelper.dart';
import 'package:apptarea_unidad4/widget/mostrar.dart';
import 'package:flutter/material.dart';
class Pagina1 extends StatefulWidget{
  const Pagina1({super.key});
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}
class Clase extends State<Pagina1>{
  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();
void _agregar() async{
  String u = usuario.text;
  String p = password.text;
   if (u.isNotEmpty && p.isNotEmpty){
    await Basedatoshelper().insertar(u,p);
    print("Usuario agregado");
    usuario.clear();
    password.clear();
   }else{
    print("Error");
   }
}
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text('Pagina 1'),
      backgroundColor: const Color.fromARGB(255, 255, 65, 157),
    ),
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 10,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  TextField(
                    controller: usuario,
                    decoration: InputDecoration(
                      labelText: 'Escribe el usuario',
                      border: OutlineInputBorder(),
                       prefixIcon: Icon(Icons.person),
                    ),),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Escribe el password',
                      border: OutlineInputBorder(),
                       prefixIcon: Icon(Icons.password),
                    ),),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _agregar, 
                      label: Text('Agregar'),
                      icon: Icon(Icons.insert_chart),
                      ),),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Mostrar(),
                            ),);
                      }, 
                      label: Text('Mostrar Usuarios'),
                      icon: Icon(Icons.insert_chart),
                      ),
                  )
              ],
               ),
          ),
          ),
        ),
        ),
   );
  }

}