import 'package:flutter/material.dart';
import '../Db/TodoDBHandler.dart';

import '../Db/Todo.dart';

Widget Fab(double height, double width, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      height: height,
      width: width,
      child: FloatingActionButton(
        onPressed: () async {
          await displayTextInputDialog(context);
        },
        tooltip: 'Add Task',
        child: Icon(
          Icons.add,
          size: 60,
          color: Colors.black,
        ),
        elevation: 10.0,
        backgroundColor: Colors.white,
      ),
    ),
  );
}

Future<void> displayTextInputDialog(context) {
  TextEditingController _controller = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("My Tasks"),
          content: TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(hintText: "enter todo"),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            FlatButton(
                onPressed: () {
                  if (_controller.text.length > 0) {
                    var todoDB = TodoDBHandler();
                    var todo = Todo(-1, _controller.text, "", 0);
                    print(todo);
                    Future<int> id = todoDB.insertTodo(todo, true);
                    id.then((value) async {
                      todo.id = value;
                    });
                    _controller.text = "";
                    print(todo);
                  }

                  Navigator.pop(context);
                },
                child: Text("Ok")),
          ],
        );
      });
}
