import 'package:flutter/material.dart';
import 'dart:convert';
import 'Fab.dart';
import 'CBottomBar.dart';
import '../Db/TodoDBHandler.dart';
import '../Db/Todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    updatex();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var x, cx;
  var l = 0, cl = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.15;
    var width = MediaQuery.of(context).size.width * 0.15;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: TextField(
                controller: _controller,
                onSubmitted: (String value) async {
                  if (value.length > 0) {
                    var todoDB = TodoDBHandler();
                    var todo = Todo(-1, value, "", 0);
                    print(todo);
                    Future<int> id = todoDB.insertTodo(todo, true);
                    id.then((value) async {
                      todo.id = value;
                      updatex();
                    });
                    _controller.text = "";
                    print(todo);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Todo",
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: l,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: Text(
                            utf8.decode(x[index]["title"]),
                            style: TextStyle(fontSize: 20),
                          ),
                          onTap: () async {
                            completed(x[index]["id"], 1);
                          });
                    }),
              ),
            ),
            Divider(),
            Expanded(
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: cl,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: Text(
                            utf8.decode(cx[index]["title"]),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 20),
                          ),
                          onTap: () async {
                            completed(cx[index]["id"], 0);
                          });
                    }),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Fab(height, width),
      bottomNavigationBar: CBottomBar(),
    );
  }

  void updatex() async {
    var todoDB = TodoDBHandler();
    var p = await todoDB.selectAllTodos();
    var t = await todoDB.selectAllCTodos();
    setState(() {
      x = p;
      l = 0;
      cx = t;
      cl = 0;
      for (Map<String, dynamic> data in x) {
        l++;
      }
      for (Map<String, dynamic> data in cx) {
        cl++;
      }
    });
  }

  void completed(int y, int z) async {
    var todoDB = TodoDBHandler();
    await todoDB.update(y, z);
    updatex();
  }
}
