import 'package:cdn_refresher/models.dart';
import 'package:flutter/cupertino.dart';

class BaseAction {

}

class AddAction extends BaseAction{
  static int id = 0;
  String desc;
  String url;
  AddAction({@required this.desc, this.url}){
    id ++;
  }
  int getId(){
    return id;
  }
}


class AddAllAction extends BaseAction{
  static int id = 0;
  List<Task> tasks;
  AddAllAction({@required this.tasks}){
    id ++;
  }
  int getId(){
    return id;
  }
}