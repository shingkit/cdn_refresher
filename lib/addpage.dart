import 'package:cdn_refresher/db_helper.dart';
import 'package:cdn_refresher/models/model.dart';
import 'package:cdn_refresher/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddState();
  }
}

class _AddState extends State<AddPage> {
  GlobalKey _RemarkKey = new GlobalKey();
  GlobalKey _contentKey = new GlobalKey();
  TextEditingController _remarkController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = new DBHelper();
    dbHelper.init();
  }

  void saveToDB(remark, content) {
    dbHelper.insert(remark, content).then((value) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('添加'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                var remark = _remarkController.text;
                var content = _contentController.text;
                if (remark.isEmpty | content.isEmpty) {
                  return;
                }
                Provider.of<AppModel>(context, listen: false).addTask(Task(remark, content));
                saveToDB(remark, content);
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("别名", style: TextStyle(fontSize: 20)),
                TextField(
                  controller: _remarkController,
                  key: _RemarkKey,
                  style: TextStyle(fontSize: 18),
                  textInputAction: TextInputAction.next,
                  onChanged: (str) => {},
                ),
                Text("列表(换行分割)", style: TextStyle(fontSize: 20)),
                TextField(
                  key: _contentKey,
                  controller: _contentController,
                  maxLines: null,
                  style: TextStyle(fontSize: 18),
                )
              ]),
        ));
  }
}
