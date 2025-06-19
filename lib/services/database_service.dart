import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/medecine.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _db;

  DatabaseService._();

  factory DatabaseService() => _instance;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'mediremind.db');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE medicines(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          dosage TEXT,
          hour INTEGER,
          minute INTEGER,
          taken INTEGER
        )
      ''');
    });
  }

  Future<int> insertMedicine(Medicine med) async {
    final dbClient = await db;
    return await dbClient.insert('medicines', med.toMap());
  }

  Future<List<Medicine>> getAllMedicines() async {
    final dbClient = await db;
    final maps = await dbClient.query('medicines');
    return maps.map((e) => Medicine.fromMap(e)).toList();
  }

  Future<int> updateMedicine(Medicine med) async {
    final dbClient = await db;
    return await dbClient.update('medicines', med.toMap(), where: 'id = ?', whereArgs: [med.id]);
  }

  Future<int> deleteMedicine(int id) async {
    final dbClient = await db;
    return await dbClient.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }
}
