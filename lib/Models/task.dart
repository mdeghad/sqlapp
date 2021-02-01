class Task{
  int id;
  String title;

  Task({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }

  Task.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
  }
}