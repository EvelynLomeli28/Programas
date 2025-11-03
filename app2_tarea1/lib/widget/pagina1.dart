import 'package:app2_tarea1/widget/pagina2.dart';
import 'package:app2_tarea1/widget/pagina3.dart';
import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<StatefulWidget> createState() {
    return Base();
  }
}
class Base extends State<Pagina1> {
  void Comparar(BuildContext context) {
    final cnum1 = n1.text;
    final cnum2 = n2.text;
    if (_llave.currentState?.validate() ?? false){
      if (int.tryParse(cnum1) != int.tryParse(cnum2)){
        if (int.tryParse(cnum1)! > int.tryParse(cnum2)!){
        Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => Pagina2(
                  c : cnum1,
                ),
              ),
              )
              ;
        }
        else{ 
          Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => Pagina3(
                    c : cnum2,
                  ),
                ),
                )
                ;
        } 
      }else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Los números son iguales, ingresa números diferentes.'),
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
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error')),
        );
    }
    
  }
   String? _vNumero1(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe numero';
      }
      final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo numeros';
      }
      return null;
    }
    String? _vNumero2(String? value){
      if (value == null || value.isEmpty){
        return 'Escribe numero';
      }
      final exp = RegExp(r'^[0-9]*$');
      if(!exp.hasMatch(value)){
        return 'Ingresa solo numeros';
      }
      return null;
    }
  final _llave = GlobalKey<FormState>();
  TextEditingController n1 = TextEditingController();
  TextEditingController n2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pagina 1'),
          backgroundColor: const Color.fromARGB(255, 101, 15, 120),
        ),
        body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            elevation: 5, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _llave,
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
                        child: TextFormField(
                          controller: n1, 
                          decoration: InputDecoration(
                            labelText: 'Escribe un número', 
                            border: OutlineInputBorder(), 
                          ),
                          validator: _vNumero1,
                        ),
                      ),
                      SizedBox(height: 8), 
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: n2, 
                          decoration: InputDecoration(
                            labelText: 'Escribe otro número',
                            border: OutlineInputBorder(),
                          ),
                          validator: _vNumero2,
                        ),
                      ),
                      SizedBox(height: 8), 
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Comparar(context);
                          },
                          child: Text('Comparar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      );
  }
}