import 'package:flutter/material.dart';
import 'package:practica1_parcial3/widget/pagina3.dart';

class Pagina2 extends StatefulWidget {
  const Pagina2({super.key});

  @override
  State<StatefulWidget> createState() {
    return Datos();
  }
}

class Datos extends State<Pagina2> {
  final _llave = GlobalKey<FormState>();
  final TextEditingController nombre = TextEditingController();
  final TextEditingController apellidos = TextEditingController();

  void validar() {
    String nom = nombre.text;
    String ape = apellidos.text;
    String cadena = "$nom - $ape";

    if (_llave.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Pagina3(cadena: cadena),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en los datos')),
      );
    }
  }

  String? _vNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Escribe el nombre';
    }
    
    // Verificar que la primera letra sea mayúscula
    if (value[0] != value[0].toUpperCase()) {
      return 'La primera letra debe ser mayúscula';
    }
    
    // Verificar que el resto sean minúsculas
    final resto = value.substring(1);
    final regexMinusculas = RegExp(r'^[a-záéíóúñ]*$');
    if (!regexMinusculas.hasMatch(resto)) {
      return 'El resto debe ser minúsculas';
    }
    
    return null;
  }

  String? _vApellidos(String? value) {
    if (value == null || value.isEmpty) {
      return 'Escribe los apellidos';
    }
    
    // Verificar que la primera letra sea mayúscula
    if (value[0] != value[0].toUpperCase()) {
      return 'La primera letra debe ser mayúscula';
    }
    
    // Verificar que el resto sean minúsculas
    final resto = value.substring(1);
    final regexMinusculas = RegExp(r'^[a-záéíóúñ\s]*$');
    if (!regexMinusculas.hasMatch(resto)) {
      return 'El resto debe ser minúsculas';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practica 1'),
        backgroundColor: const Color.fromARGB(255, 187, 57, 220),
      ),
      body: Form(
        key: _llave,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Card(
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nombre,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                        validator: _vNombre,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: apellidos,
                        decoration: const InputDecoration(
                          labelText: 'Apellidos',
                          border: OutlineInputBorder(),
                        ),
                        validator: _vApellidos,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(255, 85, 21, 110),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 80),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: validar,
                      child: const Text('Aceptar'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}