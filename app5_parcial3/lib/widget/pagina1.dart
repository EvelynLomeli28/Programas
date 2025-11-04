
import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return datos();
  }
}
class datos extends State<Pagina1>{

  void _agregar(){
    setState(() {
      final String n = nombre.text;
      final String c = correo.text;
      int numero = 0;   
      }
      );
  }
  final TextEditingController nombre = TextEditingController();
  final TextEditingController correo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listas",
        style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: const Color.fromARGB(255, 183, 58, 96),
      ),
      body: Center(
        child: Padding(padding: EdgeInsetsGeometry.all(15),
        child: Card(
          elevation: 17,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: nombre,
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder()
                  ),
                ),
                TextField(
                  controller: correo,
                  decoration: InputDecoration(
                    labelText: "Correo",
                    border: OutlineInputBorder()
                  ),
                ),
                ElevatedButton(onPressed: (){}, 
                child: Text("Agregar")),
                Expanded(child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) =>Card(
                    child: ListTile(
                      leading: Icon(Icons.account_box),
                      title: Text(""),
                      subtitle: Column(
                        children: [
                          Text("",
                          style: TextStyle(
                            fontFamily: 'Verdana',
                            fontSize: 20,
                          ),),
                          Text("data"),
                        ],
                      ),
                      trailing: Icon(Icons.forward_outlined),
                    ),
                  ) 

                ),
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