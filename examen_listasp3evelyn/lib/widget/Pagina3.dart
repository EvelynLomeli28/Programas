import 'package:examen_listasp3evelyn/widget/Pagina2.dart';
import 'package:flutter/material.dart';

class Pagina3 extends StatefulWidget{
  final List<Item> datos;
  const Pagina3({super.key,required this.datos});

  @override
  State<StatefulWidget> createState() {
    return Disenio();
  }
}
class Disenio extends State <Pagina3>{
  @override
  Widget build(BuildContext context) {
    final items =widget.datos;
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios Registrados'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
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
                title: Text(item.no),
                subtitle:Column(
                  children: [
                    Text(item.co),
                    Text(item.te),
                    Text(item.ge),
                    Text(item.clv)
                  ],
                ) ,
                trailing: IconButton(
                  color: const Color.fromARGB(255, 183, 58, 58),
                  onPressed: (){
                    setState(() {
                      
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