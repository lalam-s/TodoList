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
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32, bottom: 8, top: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "My Tasks",
                    style: TextStyle(fontSize: height / 3),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: l,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 8, top: 8, right: 8),
                              child: Text(
                                utf8.decode(x[index]["title"]),
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            onTap: () async {
                              var y = await completed(x[index]["id"], 1);
                              if (y) {
                                print("hello");
                                final snackbar = SnackBar(
                                    content: Text("1 item is marked complete"));
                                Scaffold.of(context).showSnackBar(snackbar);
                              }
                            });
                      }),
                ),
              ),
              Divider(),
              cl > 0
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 8, top: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Completed(${cl})",
                          style: TextStyle(
                              fontSize: height / 6,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Container(),
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cl,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 8, top: 8, right: 8),
                              child: Text(
                                utf8.decode(cx[index]["title"]),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 22),
                              ),
                            ),
                            onLongPress: () async {
                              var y = await delete(cx[index]["id"]);
                              if (y) {
                                print("hello");
                                final snackbar = SnackBar(
                                    content: Text("1 item is deleted"));
                                Scaffold.of(context).showSnackBar(snackbar);
                              }
                            },
                            onTap: () async {
                              var y = await completed(cx[index]["id"], 0);
                              if (y) {
                                print("hello");
                                final snackbar = SnackBar(
                                    content:
                                        Text("1 item is marked incomplete"));
                                Scaffold.of(context).showSnackBar(snackbar);
                              }
                            });
                      }),
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Fab(height, width, context),
        bottomNavigationBar: CBottomBar(context),
      ),
    );
  }

  void updatex() async {
    var todoDB = TodoDBHandler();
    var p = await todoDB.selectAllTodos(0);
    var t = await todoDB.selectAllTodos(1);
    setState(() {
      x = p;
      l = 0;
      cx = t;
      cl = 0;
      for (Map<String, dynamic> data in x) {
        l++;
        print(data);
      }
      for (Map<String, dynamic> data in cx) {
        cl++;
        print(data);
      }
    });
  }

  Future<bool> completed(int y, int z) async {
    var todoDB = TodoDBHandler();
    var i = await todoDB.update(y, z);
    updatex();
    return i;
  }

  Future<bool> delete(int y) async {
    var todoDB = TodoDBHandler();
    var i = await todoDB.delete(y);

    updatex();
    return i;
  }
}
