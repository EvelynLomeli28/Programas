import 'package:flutter/material.dart';
class Pagina1 extends StatefulWidget{
  const Pagina1({super.key});
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}

class Clase extends State<Pagina1>{
  final TextEditingController usuario = TextEditingController();
  final TextEditingController password = TextEditingController();
  void _agregar(){
    String u = usuario.text;
    String p = password.text;
    if(u.isNotEmpty && p.isNotEmpty){
    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text('Pagina 1'),
      backgroundColor: const Color.fromARGB(255, 255, 65, 141),
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
                       prefixIconColor: const Color.fromARGB(255, 183, 58, 81)
                    ),
                  ),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Escribe el password',
                      border: OutlineInputBorder(),
                       prefixIcon: Icon(Icons.password),
                       prefixIconColor: const Color.fromARGB(255, 183, 58, 108)
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _agregar, 
                      label: Text('Agregar'),
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