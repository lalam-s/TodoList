import 'package:flutter/material.dart';

Widget CBottomBar() {
  return BottomAppBar(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 14.0, right: 8.0, left: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.menu,
                size: 36,
                color: Colors.black,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 36,
                color: Colors.black,
              ),
              onPressed: () {}),
        ],
      ),
    ),
    shape: CircularNotchedRectangle(),
    color: Colors.white,
  );
}
