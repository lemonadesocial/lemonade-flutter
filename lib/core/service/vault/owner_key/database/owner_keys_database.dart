import 'package:app/core/service/vault/owner_key/owner_key.dart';
import 'package:injectable/injectable.dart';
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

  Future open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, tableOwnerKeysPath);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database _db, int version) async {
        await _db.execute('''
          create table $tableOwnerKeys ( 
            ${OwnerKeysSchema.id} text not null primary key, 
            ${OwnerKeysSchema.name} text not null,
            ${OwnerKeysSchema.type} integer not null,
            ${OwnerKeysSchema.address} text not null,
            ${OwnerKeysSchema.backup} integer not null,
            )
          ''');
      },
    );
  }

  Future<Database> get databaseInstance async {
    if (_db != null) {
      return _db!;
    }
    return await open();
  }

  Future<void> insert(OwnerKey ownerKey) async {
    final db = await databaseInstance;
    await db.insert(tableOwnerKeys, ownerKey.toJson());
  }
}
