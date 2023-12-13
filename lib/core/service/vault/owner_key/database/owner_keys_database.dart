import 'package:app/core/service/vault/owner_key/owner_key.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const tableOwnerKeys = 'ownerKeys';
const tableOwnerKeysPath = 'ownerKeys.db';

class OwnerKeysSchema {
  static const id = 'id';
  static const name = 'name';
  static const type = 'type';
  static const address = 'address';
  static const backup = 'backup';
}

@LazySingleton()
class OwnerKeysDatabase {
  Database? _db;

  Future<void> open() async {
    final databasesPath = await getApplicationDocumentsDirectory();
    final path = join(databasesPath.path, tableOwnerKeysPath);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database _db, int version) async {
        await _db.execute('''
          CREATE TABLE $tableOwnerKeys ( 
            ${OwnerKeysSchema.id} TEXT PRIMARY KEY, 
            ${OwnerKeysSchema.name} TEXT NOT NULL,
            ${OwnerKeysSchema.type} INTEGER NOT NULL,
            ${OwnerKeysSchema.address} TEXT NOT NULL,
            ${OwnerKeysSchema.backup} INTEGER NOT NULL
          )
          ''');
      },
    );
  }

  Future<Database?> get databaseInstance async {
    if (_db != null) {
      return _db!;
    }
    await open();
    return _db;
  }

  Future<void> insert(OwnerKey ownerKey) async {
    final db = await databaseInstance;
    await db?.insert(tableOwnerKeys, ownerKey.toJson());
  }
}
