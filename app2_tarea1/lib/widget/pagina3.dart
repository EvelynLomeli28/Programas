 
import 'package:flutter/material.dart';

class Pagina3 extends StatefulWidget{
  final String c;
  const Pagina3({super.key, required this.c});

  @override
  State<StatefulWidget> createState() {
    return Base();
  }
}

class Base extends State<Pagina3>{
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
        title: Text('Pagina 3'),
        backgroundColor: Colors.purple,
      ),
      body:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 200, bottom:150),
                  child: 
                  Column(
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
    );
  }
}