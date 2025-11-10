import 'package:examen_listasp3evelyn/widget/Pagina3.dart';
import 'package:flutter/material.dart';

class Pagina2 extends StatefulWidget{
  final String n;
  final String c;
  final String t;
  final String g;
  final String cl;
  const Pagina2({super.key, required this.n, required this.c, required this.t, required this.g,
  required this.cl});
  @override
  State<StatefulWidget> createState() {
    return Disenio();
  }
}
class Item{
  final String no;
  final String co;
  final String te;
  final String ge;
  final String clv;
  Item(this.no,this.co, this.te, this.ge,this.clv);
}
class Disenio extends State<Pagina2>{
  TextEditingController clave = TextEditingController();
  List<Item>datos = [];
  void verificar(){
    String cla = clave.text;
    if(cla == widget.cl){
      Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => Pagina3( 
                datos: datos
              ),
            ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Los codigos no coinciden, verificalos')),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificacion de Codigo',
        style: TextStyle(
          color: Colors.white
        ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage('https://i.pinimg.com/236x/05/2c/9d/052c9da2359097380765b6e792231e30.jpg'),
                    ),
              ),
              SizedBox(
                child: Text("Nombre: ${widget.n}"),
              ),
              SizedBox(
                child: Text("Correo: ${widget.c}"),
              ),
              SizedBox(
                child: Text("Telefono: ${widget.t}"),
              ),
              SizedBox(
                child: Text("Genero: ${widget.g}"),
              ),
              SizedBox(
                child: Text("CODIGO GENRADO: ${widget.cl}"),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextField(
                  controller: clave,
                  decoration: InputDecoration(
                  label: Text('Ingrese el codigo de verificacion'),
                  border: OutlineInputBorder()
                ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: verificar, 
                child: Text("Verificar")),
              )
            ],
          ),
          ),

      ),
    );
  }
}