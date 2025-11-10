 import 'package:flutter/material.dart';
class Pagina2 extends StatefulWidget{
  final String c;
  const Pagina2({super.key, required this.c});
  @override
  State<StatefulWidget> createState() {
    return Base();
  }
}
class Base extends State<Pagina2>{
  void Elevar(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado'),
          content: Text('El resultado de elevar al cuadrado es: ${int.parse(widget.c) * int.parse(widget.c)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 2'),
        backgroundColor: Colors.purple,
      ),
      body:Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom:15, left: 15, right: 15 ),
                  child: 
                  Card(
                    color: const Color.fromARGB(129, 255, 255, 255),
                    elevation: 10, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('${widget.c}',),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: Elevar,
                            child: Text('Elevar')),
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