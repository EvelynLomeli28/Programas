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
    String path = join(await getDatabasesPath(), 'usuarios.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''
            CREATE TABLE usuarios(
             id INTEGER PRIMARY KEY AUTOINCREMENTE,
             usuario TEXT NOT NULL,
             password TEXT NOT NULL,
            )
          ''');
      }
    );
   }

    Future<int> insertar(String usuario, String password) async{
      final db = await database;
      return await db.insert('usuarios',{
        'usuario' : usuario,
        'password' : password,
      });
    }

   
}