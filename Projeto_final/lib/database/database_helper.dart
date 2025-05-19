import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Consulta.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('consultas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print('Opening database at $path');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE consultas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        especialidade TEXT,
        local TEXT,
        data TEXT,
        hora TEXT,
        status TEXT
      )
    ''');
  }

  Future<int> insertConsulta(Consulta consulta) async {
    final db = await instance.database;
    return await db.insert(
      'consultas',
      consulta.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> updateConsulta(Consulta consulta) async {
    final db = await instance.database;
    int result = await db.update(
      'consultas',
      consulta.toMap(),
      where: 'id = ?',
      whereArgs: [consulta.id],
    );
    print('Registros afetados: $result');
    return result;
  }

  Future<List<Consulta>> getConsultas() async {
    final db = await instance.database;
    final result = await db.query('consultas');

    return result.map((json) => Consulta.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> deleteConsulta(int id) async {
    final db = await instance.database;

    return await db.delete(
      'consultas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}





