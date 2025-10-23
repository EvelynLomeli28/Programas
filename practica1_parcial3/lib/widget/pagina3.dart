import 'package:flutter/material.dart';

class Pagina3 extends StatefulWidget {
  final String cadena;
  const Pagina3({super.key, required this.cadena});

  @override
  State<StatefulWidget> createState() {
    return Clases();
  }
}

class Clases extends State<Pagina3> {
  String a = "";
  String p1 = "";

  @override
  void initState() {
    super.initState();
    // Separar la cadena usando " - " como delimitador
    int p = widget.cadena.indexOf(" - ");
    if (p != -1) {
      a = widget.cadena.substring(0, p);
      p1 = widget.cadena.substring(p + 3); // +3 para saltar " - "
    } else {
      // Si no encuentra el separador, usar toda la cadena como nombre
      a = widget.cadena;
      p1 = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              a,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              p1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Datos Recibidos:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre: $a',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Apellidos: $p1',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}