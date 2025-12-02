import 'package:apptarea_unidad4/basededatos/basededatoshelper.dart';
import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});
  @override
  State<StatefulWidget> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  List<Map<String, dynamic>> _usuarios = [];
  bool _cargando = false;
  int _totalUsuarios = 0;

  @override
  void initState() {
    super.initState();
    _inicializarApp();
  }

  Future<void> _inicializarApp() async {
    await _cargarUsuarios();
    await _verificarBaseDatos();
  }

  Future<void> _verificarBaseDatos() async {
    final estadisticas = await Basedatoshelper().obtenerEstadisticas();
    print("📊 Estado BD: ${estadisticas['mensaje']}");
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Usuarios en BD: ${estadisticas['total']}'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> _cargarUsuarios() async {
    setState(() => _cargando = true);
    
    try {
      final usuarios = await Basedatoshelper().obtenerUsuarios();
      setState(() {
        _usuarios = usuarios;
        _totalUsuarios = usuarios.length;
      });
    } catch (e) {
      print("Error al cargar usuarios: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _cargando = false);
    }
  }

  Future<void> _agregarUsuario() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _cargando = true);
    
    try {
      await Basedatoshelper().insertar(
        _nombreController.text,
        _correoController.text,
      );
      
      // Limpiar formulario
      _nombreController.clear();
      _correoController.clear();
      
      // Recargar lista
      await _cargarUsuarios();
      
      // Mostrar mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Usuario agregado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _cargando = false);
    }
  }

  Future<void> _eliminarUsuario(int id, String nombre) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar al usuario "$nombre"?'),
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
        await Basedatoshelper().eliminarUsuario(id);
        await _cargarUsuarios();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ "$nombre" eliminado'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuarios'),
        backgroundColor: const Color.fromARGB(255, 255, 65, 157),
        actions: [
          // Indicador de carga
          if (_cargando)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // FORMULARIO
          Container(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa un nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _correoController,
                        decoration: const InputDecoration(
                          labelText: 'Correo',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa un correo';
                          }
                          if (!value.contains('@')) {
                            return 'Correo no válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _cargando ? null : _agregarUsuario,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 65, 157),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          icon: const Icon(Icons.person_add),
                          label: const Text('AGREGAR USUARIO'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // INFO DE USUARIOS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Usuarios registrados: $_totalUsuarios',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _cargando ? null : _cargarUsuarios,
                  tooltip: 'Actualizar lista',
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // LISTA DE USUARIOS
          Expanded(
            child: _cargando && _usuarios.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _usuarios.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No hay usuarios registrados',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _usuarios.length,
                        itemBuilder: (context, index) {
                          final usuario = _usuarios[index];
                          return Dismissible(
                            key: Key(usuario['id'].toString()),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Eliminar'),
                                  content: Text(
                                      '¿Eliminar a ${usuario['nombre']}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onDismissed: (direction) {
                              Basedatoshelper()
                                  .eliminarUsuario(usuario['id'] as int);
                              setState(() {
                                _usuarios.removeAt(index);
                                _totalUsuarios--;
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 65, 157),
                                  child: Text(
                                    usuario['clave']?.toString().substring(0, 2) ??
                                        '??',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  usuario['nombre']?.toString() ?? 'Sin nombre',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('Clave: ${usuario['clave']}'),
                                    Text('Correo: ${usuario['correo']}'),
                                    Text(
                                      'ID: ${usuario['id']}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _eliminarUsuario(
                                    usuario['id'] as int,
                                    usuario['nombre'].toString(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}