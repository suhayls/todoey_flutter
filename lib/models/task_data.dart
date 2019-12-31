import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:collection/collection.dart';
import 'package:todoey_flutter/models/store_manager.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];
  StoreManager storeManager = StoreManager();

  void init() async {
    await storeManager.open();
    _tasks = await storeManager.getTasks();
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  Future addTask(String newTaskTitle) async {
    Task task = Task(name: newTaskTitle);
    task = await storeManager.insert(task);
    _tasks.add(task);

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
