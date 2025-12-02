import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Basedatoshelper {
   static final Basedatoshelper _instance = Basedatoshelper._internal();
   factory Basedatoshelper() => _instance;

   Basedatoshelper._internal();

   Database? _database;

   Future<Database> get database async{
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
   }

   Future <Database> _initDB() async{
    String path = join(await getDatabasesPath(), 'vehiculos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''
            CREATE TABLE vehiculos(
             codigo text ,
             marca TEXT NOT NULL,
             modelo TEXT NOT NULL,
             precio integer not null
            )
          ''');
      }
    );
   }
    String _generarClave(String codigo, String modelo) {
   
    String codigog = codigo.trim();
    
    String iniciales = codigog.length >= 3 
        ? codigog.substring(0, 3).toUpperCase()
        : modelo.toUpperCase().padRight(3, 'X');
    
    Random random = Random();
    int numeroRandom = 100 + random.nextInt(901);
    
    return '$iniciales$numeroRandom';
  }
    Future<int> insertar(String marca, String codigo, String modelo, String precio) async{
      final db = await database;
      return await db.insert('vehiculos',{
        'codigo' : codigo,
        'marca' : marca,
        'modelo' : modelo,
        'precio' : precio,
      });
    }


    Future<List<Map<String, dynamic>>> obtenerUsuario() async{
       final db = await database;
       return await db.query('vehiculos');
    }

    Future eliminar(String codigo) async{
      final db = await database;
      return await db.delete('vehiculos', where : 'codigo = ?',whereArgs: [codigo]);
    }

    Future<int> modificar (String ncodigo, String nmarca, String nmodelo, String nprecio)async{
       final db = await database;
       return await db.update(
        'vehiculos', 
        {'marca':nmarca, 'modelo':nmodelo, 'precio': nprecio},
        where: 'codigo= ?', 
        whereArgs: [ncodigo],
        );
    }

   
}