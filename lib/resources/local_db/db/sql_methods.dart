import 'dart:io';
import 'package:path/path.dart';
import 'package:chat_bit/models/log.dart';
import 'package:chat_bit/resources/local_db/interface/log_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteMethods implements LogInterface {
  Database _db;
  String databaseName = "";
  String tableName = "Call_Logs";

  String id = "log_id";
  String callerName = "caller_name";
  String callerPic = "caller_pic";
  String receiverName = "receiver_name";
  String receiverPic = "receivr_pic";
  String callStatus = "call_status";
  String timestamp = "timestamp";

  Future<Database> get db async {
    if (db != null) {
      return _db;
    }
    print("db was null, awaiting now.");
    _db = await init();
    return _db;
  }

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String createTableQuery =
        "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $callerName TEXT, $callerPic TEXT, $receiverName TEXT, $receiverPic TEXT, $callStatus TEXT, $timestamp TEXT)";

    await db.execute(createTableQuery);
    print('Table Created');
  }

  @override
  addLogs(Log log) async {
    var dbClient = await db;
    await dbClient.insert(tableName, log.toMap(log));
  }

  @override
  deleteLogs(int logId) async {
    var dbCLient = await db;
    return await dbCLient
        .delete(tableName, where: '$id = ?', whereArgs: [logId + 1]);
  }

  @override
  openDb(dbName) => (databaseName = dbName);

  @override
  Future<List<Log>> getLogs() async {
    try {
      var dbCLient = await db;
      List<Map> maps = await dbCLient.query(
        tableName,
        columns: [
          id,
          callerName,
          callerPic,
          receiverName,
          receiverPic,
          callStatus,
          timestamp,
        ],
      );

      List<Log> logList = [];
      if (maps.isNotEmpty) {
        for (Map map in maps) {
          logList.add(Log.fromMap(map));
        }
      }

      return logList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
