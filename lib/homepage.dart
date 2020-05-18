import 'package:cdn_refresher/addpage.dart';
import 'package:cdn_refresher/db_helper.dart';
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
  @override
  void initState() {
    super.initState();
  }

  void initData(store) async {
    DBHelper dbHelper = new DBHelper();
    dbHelper.init().then((value) async {
      dbHelper.queryAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Task>>(
      converter: (store) => store.state.tasks,
      onInit: (store) {
        initData(store);
      },
      builder: (context, list) => Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              return Card(
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(8),
                  child: Text(list[index].remark),
                ),
                color: Colors.white,
                elevation: 5,
              );
            }).build(context),
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
