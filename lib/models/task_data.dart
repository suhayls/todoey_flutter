import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:collection/collection.dart';
import 'package:todoey_flutter/models/store_manager.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];
  StoreManager storeManager = StoreManager();

  void init() async {
    _tasks = await storeManager.getTasks();
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) async {
    Task task = Task(name: newTaskTitle);
    _tasks.add(task);

    storeManager.insert(task);
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void updateTask(Task task) {
    task.toggleDone();
    storeManager.update(task);

    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    storeManager.delete(task.tid);

    notifyListeners();
  }
}
