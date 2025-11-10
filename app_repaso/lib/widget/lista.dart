import 'package:flutter/material.dart';
import 'datos.dart';

class Lista extends StatefulWidget{
  final List<Item> items;
  const Lista({super.key, required this.items});

  @override
  State<StatefulWidget> createState() {
    return Disenio();
  }
}
class Disenio extends State<Lista>{
  @override
  Widget build(BuildContext context) {
    final items =widget.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas de promedios'),
      ),
      body: items.isEmpty
      ?Center(
        child: Text("Lista Vacia"),
      ):
      Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child:ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index){
              final item = items[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                leading: Icon(Icons.person),
                title: Text(item.nom),
                subtitle:Column(
                  children: [
                    Text(item.c1),
                    Text(item.c2),
                    Text(item.c3)
                  ],
                ) ,
                trailing: IconButton(
                  color: const Color.fromARGB(255, 183, 58, 58),
                  onPressed: (){
                    setState(() {
                      String prom;
                      
                    });
                  }, 
                  icon: Icon(Icons.calculate)),
              ),
              );   
            } ,
            ) ,
          ),
      
      ),
    );
  }
}