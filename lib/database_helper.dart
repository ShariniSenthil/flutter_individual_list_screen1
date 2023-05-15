import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "CA_DB.db";
  static const _databaseVersion = 6;

  // Individual
  static const individualsTable = 'individuals_table';

  // Group table
  static const groupNameTable = 'group_name_table';

  // Bank Details table
  static const bankDetailsTable = 'bank_details_table';

  // Address table
  static const addressTable = 'address_table';

  // _id column common for all table
  static const columnId = '_id';

  // Group table column
  static const columnGroupName = '_groupName';

  // Bank Details table column
  static const columnBankName = '_bankName';
  static const columnBranch = '_branch';
  static const columnAccountType = '_accountType';
  static const columnAccountNo = '_accountNo';
  static const columnIFSCcode = '_IFSCcode';

  // Address table column
  static const columnName = '_name';
  static const columnDesignation = '_designation';
  static const columnContactNoLandlineNo = '_contactNoLandlineNo';
  static const columnEmail = '_email';

  // Individual table column
  static const columnImage = '_image';
  static const columnFirstLastName = '_firstLastName';
  static const columnMiddleName = '_middleName';
  static const columnBusinessName = '_businessName';
  static const columnBusinessStartDate = '_businessStartDate';
  static const columnNatureofBusiness = '_natureofBusiness';
  static const columnPanNumber = '_panNumber';
  static const columnGSTin = '_GSTin';
  static const columnRegOfficeAddress = '_regOfficeAddress';
  static const columnPincode = '_pincode';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database database, int version) async {

    await database.execute('''
          CREATE TABLE $groupNameTable (
            $columnId INTEGER PRIMARY KEY,
            $columnGroupName TEXT
          )
          ''');

    await database.execute('''
          CREATE TABLE $bankDetailsTable (
            $columnId INTEGER PRIMARY KEY,
            $columnBankName TEXT,
            $columnBranch TEXT,
            $columnAccountType TEXT,
            $columnAccountNo TEXT,
            $columnIFSCcode TEXT
          )
          ''');

    await database.execute('''
          CREATE TABLE $addressTable (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT,
            $columnDesignation TEXT,
            $columnContactNoLandlineNo TEXT,
            $columnEmail TEXT
          )
          ''');

    await database.execute('''
          CREATE TABLE $individualsTable (
            $columnId INTEGER PRIMARY KEY,
            $columnImage TEXT,
            $columnFirstLastName TEXT,
            $columnMiddleName TEXT,
            $columnBusinessName TEXT,
            $columnBusinessStartDate TEXT,
            $columnNatureofBusiness TEXT,
            $columnPanNumber TEXT,
            $columnGSTin TEXT,
            $columnRegOfficeAddress TEXT,
            $columnPincode TEXT,
            $columnGroupName TEXT
          )
          ''');
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async{
    await database.execute('drop table $groupNameTable');
    await database.execute('drop table $bankDetailsTable');
    await database.execute('drop table $addressTable');
    await database.execute('drop table $individualsTable');
    _onCreate(database, newVersion);
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    return await _db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    return await _db.query(tableName);
  }

  Future<int> queryRowCount(String tableName) async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $tableName');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row, String tableName) async {
    int id = row[columnId];
    return await _db.update(
      tableName,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id, String tableName) async {
    return await _db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  readDataById(table, itemId) async{
    return await _db.query(table, where: "_id =? ",whereArgs: [itemId]);
  }

  // Read data from table by column name
  readDataByColumnName(table, columnName, columnValue) async{
    return await _db?.query(table, where: '$columnName =? ', whereArgs: [columnValue]);
  }
}