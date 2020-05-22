import 'package:cdn_refresher/addpage.dart';
import 'package:cdn_refresher/db_helper.dart';
import 'package:cdn_refresher/http_client.dart';
import 'package:cdn_refresher/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBHelper dbHelper = new DBHelper();
  GlobalKey _refreshIndicatorKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    dbHelper.close();
    super.dispose();
  }

  void initData() async {
    dbHelper.init().then((value) async {
      dbHelper.queryAll().then((value) => {
      });
    });
  }

  void removeTask(task) {
    dbHelper.removeTask(task).then((value) {
      if (value > 0) {
        print("删除任务 " + task.id.toString() + "成功，查询全部");
        initData();
      }
    });
  }

  Widget buildItem(BuildContext context, List<Task> list, int index) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('确定要删除吗？'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                removeTask(list[index]);
                                Navigator.of(context).pop();
                              },
                              child: Text('确定')),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('取消'))
                        ],
                      );
                    });
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.all(8),
                child: Text(list[index].remark + ':${list[index].id}'),
              ),
            ),
          ),
          FlatButton(
            child: Text("刷新"),
            onPressed: () {
              HttpClient().requestRefresh(list[index].url).then((value) => {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('刷新成功'),
                    ))
                  });
            },
          )
        ],
      ),
      color: Colors.white,
      elevation: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Task>>(
      converter: (store) => store.state.tasks,
      builder: (context, list) => Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async{
            initData();
            return;
          },
          child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, index) => buildItem(ctx, list, index))
              .build(context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext buildContext) {
              return AddPage();
            }))
          },
          tooltip: '添加',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
