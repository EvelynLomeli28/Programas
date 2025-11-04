
import 'package:app5_parcial3/widget/detalles.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class Lista extends StatefulWidget{
  const Lista({super.key});

  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
}
class Item{
  final String clave;
  final String nombre;
  final String correo;
  Item(this.clave, this.nombre,this.correo);
}
class Clase extends State<Lista>{
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
List<Item> items =[];

void _agregar(){
   setState(() {
     final String n = nombre.text;
     final String c = correo.text;
     int numero = Random().nextInt(100);
     if(n.isNotEmpty && c.isNotEmpty){
        final String clave = numero.toString() + n.substring(0,2).toUpperCase();
        print(clave);
        items.add(Item('$clave','$n','$c'));
        nombre.clear();
        correo.clear();
     }else{
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Faltan datos")),
      );
     }
   });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        backgroundColor: const Color.fromARGB(255, 183, 58, 98),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
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
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: correo,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _agregar, 
                      label: Text('Agregar')
                      ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(items[index].clave),
                          subtitle: Column(
                            children: [
                              Text(items[index].nombre,style: TextStyle(
                                fontFamily: "Arial",
                                fontSize: 20,
                              ),),
                              Text(items[index].correo),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            print(items[index].clave+items[index].nombre+items[index].correo);
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => Detalles(
                                  clave : items[index].clave,
                                  nombre : items[index].nombre,
                                  correo : items[index].correo,
                                ),
                              ),
                              );
                          },
                        ),
                      ),
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