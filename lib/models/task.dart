class Task {
  int tid;
  String name;
  bool isDone;

  Task({this.tid, this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'name': name, 'isDone': isDone};
    if (tid != null) {
      map['tid'] = tid;
    }
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    tid = map['tid'];
    name = map['name'];
    isDone = map['isDone'] == 1;
  }
}
