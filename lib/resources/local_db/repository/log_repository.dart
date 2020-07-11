import 'package:chat_bit/models/log.dart';
import 'package:meta/meta.dart';
import 'package:chat_bit/resources/local_db/db/hive_methods.dart';
import 'package:chat_bit/resources/local_db/db/sql_methods.dart';

class LogRepository {
  static var dbObject;
  static bool isHive;

  static init({@required bool isHive, @required String dbName}) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
    dbObject.openDb(dbName);
    dbObject.init();
  }

  static addLogs(Log log) => dbObject.addLogs(log);

  static deleteLogs(int logId) => dbObject.deleteLogs(logId);

  static getLogs() => dbObject.getLogs();

  static close() => dbObject.close();
}
