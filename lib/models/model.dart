import 'package:cdn_refresher/models/task.dart';
import 'package:flutter/foundation.dart';

class AppModel extends ChangeNotifier{
  List<Task> tasks = [];

  addTask(Task task){
    tasks.add(task);
    notifyListeners();
  }

  setTasks(List<Task> tasks){
    this.tasks = tasks;
    notifyListeners();
  }
}
