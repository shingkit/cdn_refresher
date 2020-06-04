import 'package:cdn_refresher/models/task.dart';
import 'package:sqflite/sqflite.dart';

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
    await db.rawInsert(
        'INSERT INTO $TABLE_LIST($columnRemark, $columnURL)VALUES(?,?)',
        [remark, url]);
  }

  Future queryAll() async {
    List<Map<String, dynamic>> list =
        await db.rawQuery('select * from $TABLE_LIST');
    List<Task> result = new List();
    if (list != null && list.length > 0) {
      for (int i = 0; i < list.length; i++){
        Map item = list[i];
        result.add(new Task(item["_remark"], item["_url"], id: item["_id"]));
      }
    }
    return result;
  }

  void close(){
    if (db.isOpen){
      db.close();
    }
  }

  Future<int> removeTask(Task task) async {
    var id = task.id.toInt();
    int size = await db.rawDelete('delete from $TABLE_LIST where $columnId = ?', [id]);
    return size;
  }
}
