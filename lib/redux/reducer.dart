import 'package:cdn_refresher/models.dart';
import 'package:cdn_refresher/redux/actions.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BaseState {}

List<Task> tasksReducer(List<Task> state, action) {
  if (action is AddAction) {
    return <Task>[]
      ..addAll(state)
      ..add(new Task(action.desc, action.url));
  }
  if (action is AddAllAction){
    return <Task>[]
//      ..addAll(state)
      ..addAll(action.tasks);
  }
  return state;
}

AppState appReducer(AppState state, action) {
  return new AppState(tasks: tasksReducer(state.tasks, action));
}
