

import 'package:flutter/material.dart';
class Lista2 extends StatefulWidget{
  const Lista2({super.key});
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
} 

class Item{
  final String produc;
  final String descrip;
  final String preci;
  Item(this.produc, this.descrip, this.preci);
}

class Clase extends State<Lista2>{
  TextEditingController producto = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController precio = TextEditingController();
List<Item> items=[

];
  void _agrear(){
    setState(() {
      final String p= producto.text;
      final String d= descripcion.text;
      final String pr = precio.text;
      if(p.isNotEmpty && d.isNotEmpty && pr.isNotEmpty){
         items.add(Item('Producto: $p', 'Descripcion: $d','Precio: $pr'));
         producto.clear();
         descripcion.clear();
         precio.clear();
      }else{
        print("Datos vacios");
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista personalizada'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              TextField(
                controller: producto,
                decoration: InputDecoration(
                  labelText: 'Escribe un producto',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: descripcion,
                decoration: InputDecoration(
                  labelText: 'Escribe la Descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: precio,
                decoration: InputDecoration(
                  labelText: 'Escribe el precio',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: _agrear, 
                  label: Text('Agregar',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  ),
                  ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder:(context, index)=>Card(
                    child: ListTile(
                      leading: Icon(Icons.wysiwyg_sharp),
                      title: Text(items[index].produc),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[index].descrip),
                          Text(items[index].preci),
                        ],
                      ),
                      trailing: Icon(Icons.apartment_outlined),
                    ),
                  ), 
                  ),
                ),
            ],
          ),
        ),
        ),
    );
  }

}