import 'package:examen_unidad4/basededatos/basededatoshelper.dart';
import 'package:flutter/material.dart';


class PaginaListaVehiculos extends StatefulWidget {
const PaginaListaVehiculos({super.key});
  @override
  State<StatefulWidget> createState() {
    return Clase();
  }
} 
class Clase extends State<PaginaListaVehiculos>{
  List<Map<String, dynamic>> vehiculos = [];
  String nombre = "";
  int color1=0;
  int color2=0;
  int color3=0;
  @override
  void initState() {
    super.initState();
    cargarDatos();
  }
  void cargarDatos() async {
    List<Map<String, dynamic>> datos = await Basedatoshelper().obtenerUsuario();
    setState(() {
      vehiculos = datos;
    });
    print("Vehiculos cargados: ${vehiculos}");
  }
  Future<void> _eliminarUsuario(String codigo) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar el vehiculo "$codigo"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      try {
        await Basedatoshelper().eliminar(codigo);
        cargarDatos();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"$nombre" eliminado'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

void _modificar(String codigo, String marca, String modelo, String precio){
      TextEditingController marcanuevo = TextEditingController();
      TextEditingController modelonuevo = TextEditingController();
      TextEditingController precionuevo = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Vehiculo'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: marcanuevo,
                  decoration: InputDecoration(
                    labelText: '${marca}'
                  ),
                ),
                TextField(
                  controller: modelonuevo,
                  decoration: InputDecoration(
                    labelText: 'Escribe el modelo'
                  ),
                ),
                TextField(
                  controller: precionuevo,
                  decoration: InputDecoration(
                    labelText: 'Escribe el precio'
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async{
                 await Basedatoshelper().modificar(codigo, marcanuevo.text, modelonuevo.text, precionuevo.text);
                 cargarDatos();
                 Navigator.pop(context);
              }, 
              child: Text('Guardar'),
              ),
              TextButton(
              onPressed: ()=>Navigator.pop(context),
              child: Text('Cancelar'),
              ),
          ],
        );
      }
      );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Vehículos")),
      body: vehiculos.isEmpty
        ? Center(child: Text('Base de datos vacía'))
        : ListView.builder(
          itemCount: vehiculos.length,
          itemBuilder: (context, index){
            nombre = vehiculos[index]['vehiculo'][0];
            return ListTile(
              leading: CircleAvatar(
                //backgroundColor:  Color.fromARGB(0, 0, 0, 0),
                child: Text(nombre.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
                ),
              ),
              title: Text(vehiculos[index]['marca']),
              subtitle: Text(vehiculos[index]['modelo']),
              trailing: Wrap(
                direction: Axis.horizontal,
                children: [
                  IconButton(
                    onPressed:(){ 
                      _eliminarUsuario(vehiculos[index]['codigo']);
                      }, 
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed:(){ 
                      _modificar(vehiculos[index]['codigo'],vehiculos[index]['marca'],vehiculos[index]['modelo'],vehiculos[index]['precio']);
                      }, 
                    icon: Icon(Icons.update),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}
