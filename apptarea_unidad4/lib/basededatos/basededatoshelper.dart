import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

class Basedatoshelper {
  static final Basedatoshelper _instance = Basedatoshelper._internal();
  factory Basedatoshelper() => _instance;
  Basedatoshelper._internal();

  static Database? _database;
  bool _baseDatosInicializada = false;

  Future<Database> get database async {
    if (_database != null && _baseDatosInicializada) return _database!;
    _database = await _initDatabase();
    _baseDatosInicializada = true;
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'usuarios.db');
    
    return await openDatabase(
      path,
      version: 1, // Mantén la misma versión
      onCreate: _onCreate,
      onOpen: (db) async {
        // Verificar estructura al abrir, sin borrar datos
        await _verificarYEstructurar(db);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _crearTabla(db);
    print("Tabla 'usuarios' creada exitosamente");
  }

  Future<void> _verificarYEstructurar(Database db) async {
    try {
      // Verificar si la tabla existe
      List<Map> tablas = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='usuarios'"
      );
      
      if (tablas.isEmpty) {
        print("La tabla 'usuarios' no existe. Creándola...");
        await _crearTabla(db);
      } else {
        // Verificar estructura de columnas
        List<Map> estructura = await db.rawQuery("PRAGMA table_info(usuarios)");
        print("Verificando estructura de la tabla...");
        
        // Lista de columnas requeridas
        List<String> columnasRequeridas = ['id', 'clave', 'nombre', 'correo'];
        List<String> columnasExistentes = [];
        
        for (var columna in estructura) {
          String nombreColumna = columna['name'].toString();
          columnasExistentes.add(nombreColumna);
          print("  - $nombreColumna: ${columna['type']}");
        }
        
        // Verificar si faltan columnas
        for (var requerida in columnasRequeridas) {
          if (!columnasExistentes.contains(requerida)) {
            print("Falta columna: $requerida. Intentando agregar...");
            try {
              if (requerida == 'id') {
                await db.execute('ALTER TABLE usuarios ADD COLUMN id INTEGER PRIMARY KEY AUTOINCREMENT');
              } else {
                await db.execute('ALTER TABLE usuarios ADD COLUMN $requerida TEXT');
              }
              print("Columna $requerida agregada");
            } catch (e) {
              print("Error al agregar columna $requerida: $e");
            }
          }
        }
      }
    } catch (e) {
      print("Error al verificar estructura: $e");
    }
  }

  Future<void> _crearTabla(Database db) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        clave TEXT,
        nombre TEXT,
        correo TEXT
      )
    ''');
  }

  // Generar clave automática
  String _generarClave(String nombre) {
    // Limpiar el nombre
    String nombreLimpio = nombre.trim();
    
    // Obtener primeras dos letras en mayúsculas
    String iniciales = nombreLimpio.length >= 2 
        ? nombreLimpio.substring(0, 2).toUpperCase()
        : nombreLimpio.toUpperCase().padRight(2, 'X');
    
    // Número random entre 100 y 1000
    Random random = Random();
    int numeroRandom = 100 + random.nextInt(901);
    
    return '$iniciales$numeroRandom';
  }

  // Insertar usuario
  Future<int> insertar(String nombre, String correo) async {
    try {
      final Database db = await database;
      
      // Limpiar datos
      String nombreLimpio = nombre.trim();
      String correoLimpio = correo.trim();
      
      if (nombreLimpio.isEmpty || correoLimpio.isEmpty) {
        throw Exception("Nombre y correo no pueden estar vacíos");
      }
      
      // Generar clave automática
      String clave = _generarClave(nombreLimpio);
      
      print("Insertando usuario:");
      print("  - Clave: $clave");
      print("  - Nombre: $nombreLimpio");
      print("  - Correo: $correoLimpio");
      
      // Insertar en la base de datos
      int id = await db.insert(
        'usuarios',
        {
          'clave': clave,
          'nombre': nombreLimpio,
          'correo': correoLimpio,
        },
      );
      
      print("Usuario insertado con ID: $id");
      return id;
      
    } catch (e) {
      print("Error al insertar usuario: $e");
      rethrow;
    }
  }

  // Obtener todos los usuarios
  Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
    try {
      final Database db = await database;
      
      // Verificar si la tabla existe
      List<Map> tablas = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='usuarios'"
      );
      
      if (tablas.isEmpty) {
        print("La tabla 'usuarios' no existe");
        return [];
      }
      
      // Intentar obtener usuarios con ORDER BY, si falla, sin ORDER BY
      try {
        return await db.query('usuarios', orderBy: 'id DESC');
      } catch (e) {
        print("Error con ORDER BY, usando sin orden: $e");
        return await db.query('usuarios');
      }
      
    } catch (e) {
      print("Error al obtener usuarios: $e");
      return [];
    }
  }

  // Eliminar usuario por id
  Future<int> eliminarUsuario(int id) async {
    try {
      final Database db = await database;
      return await db.delete(
        'usuarios',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error al eliminar usuario: $e");
      return 0;
    }
  }

  // Obtener estadísticas
  Future<Map<String, dynamic>> obtenerEstadisticas() async {
    try {
      final Database db = await database;
      
      // Total de usuarios
      List<Map> resultado = await db.rawQuery(
        "SELECT COUNT(*) as total FROM usuarios"
      );
      int total = resultado.first['total'] as int;
      
      return {
        'total': total,
        'mensaje': 'Base de datos funcionando correctamente',
      };
    } catch (e) {
      return {
        'total': 0,
        'mensaje': 'Error: $e',
      };
    }
  }
}