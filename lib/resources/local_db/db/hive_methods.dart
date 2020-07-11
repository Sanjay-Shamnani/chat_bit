import 'dart:io';

import 'package:chat_bit/models/log.dart';
import 'package:chat_bit/resources/local_db/interface/log_interface.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveMethods implements LogInterface {
  String hive_box = "";

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  @override
  openDb(dbName) => (hive_box = dbName);

  @override
  addLogs(Log log) async {
    var box = await Hive.openBox(hive_box);
    var logMap = log.toMap(log);
    int idOfInput = await box.add(logMap);
    close();
    return idOfInput;
  }

  updateLogs(int i, Log log) async {
    var box = await Hive.openBox(hive_box);
    var logMap = log.toMap(log);
    box.putAt(i, logMap);
    close();
  }

  @override
  deleteLogs(int logId) async {
    var box = await Hive.openBox(hive_box);
    await box.deleteAt(logId);
    close();
  }

  @override
  Future<List<Log>> getLogs() async {
    var box = await Hive.box(hive_box);
    List<Log> logList = [];
    for (int i = 0; i < box.length; i++) {
      var logMap = box.getAt(i);
      logList.add(logMap);
    }
    return logList;
  }

  @override
  close() => Hive.close();
}
