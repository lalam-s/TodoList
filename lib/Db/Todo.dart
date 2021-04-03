import 'dart:convert';

class Todo {
  int id;
  String title;
  String content = "";
  int iscompleted = 0;
  Todo(this.id, this.title, this.content, this.iscompleted);
  Map<String, dynamic> toMap(bool forUpdate) {
    if (forUpdate) {
      completetask();
    }
    var data = {
      'title': utf8.encode(title),
      'content': utf8.encode(content),
      'iscompleted': iscompleted,
    };
    if (forUpdate) {
      data["id"] = this.id;
    }
    return data;
  }

  void completetask() {
    if (iscompleted == 0)
      iscompleted = 1;
    else
      iscompleted = 0;
  }

  @override
  toString() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'iscompleted': iscompleted,
    }.toString();
  }
}
