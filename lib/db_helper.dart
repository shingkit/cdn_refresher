import 'package:cdn_refresher/bean.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBHelper {
  static const String TABLE_LIST = "list";
  static const String columnId = "_id";
  static const String columnRemark = "_remark";
  static const String columnURL = "_url";

  static const String CREATE_TABLE =
      'CREATE TABLE $TABLE_LIST($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnRemark text not null,$columnURL text not null);';
  Database db;

  Future init() async {
    var path = await getDBPath();
    db = await openDatabase(path, version: 1,
        onCreate: (Database db1, int version) async {
      await db1.execute(CREATE_TABLE);
    });
  }

  Future getDBPath() async {
    return await getDatabasesPath() + "/x.db";
  }

  Future insert(remark, url) async {
    await db.execute(
        'INSERT INTO $TABLE_LIST($columnRemark, $columnURL)VALUES(?,?)',
        [remark, url]);
  }

  Future queryAll() async {
    List<Map<String, dynamic>> list =
        await db.rawQuery('select * from $TABLE_LIST');
    List<CDNItem> result = new List();
    if (list != null && list.length > 0) {
      for (int i = 0; i < list.length; i++){
        Map item = list[i];
        result.add(new CDNItem(item["_id"], item["_remark"], item["_url"]));
      }
    }
    return result;
  }
}
