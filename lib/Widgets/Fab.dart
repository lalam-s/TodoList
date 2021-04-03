import 'package:flutter/material.dart';
import '../Db/TodoDBHandler.dart';
import 'dart:convert';

Widget Fab(double height, double width) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      height: height,
      width: width,
      child: FloatingActionButton(
        onPressed: () async {
          var todoDB = TodoDBHandler();
          var x = await todoDB.selectAllTodos();
          var l = [];
          for (Map<String, dynamic> data in x) {
            l.add(data["id"]);
          }
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
