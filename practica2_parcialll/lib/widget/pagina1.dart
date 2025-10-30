import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pagina1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Disenio();
  }
}
class Disenio extends State<Pagina1>{
  TextEditingController n1=TextEditingController();
  TextEditingController n2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 1'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            elevation: 18, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), 
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: n1,
                        keyboardType: TextInputType.number, 
                        decoration: InputDecoration(
                          labelText: 'Escribe un número', 
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8), 
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: n2, 
                        decoration: InputDecoration(
                          labelText: 'Escribe otro número',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: Text('Sumar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}