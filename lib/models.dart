import 'package:flutter/material.dart';

class Task {
  int id;
  String remark;
  String url;
  String lastRefreshTime;

  Task(this.remark, this.url, {this.id});
}

class AppState {
  final List<Task> tasks;

  const AppState({@required this.tasks});

  AppState.initialState() : tasks = <Task>[];
}
