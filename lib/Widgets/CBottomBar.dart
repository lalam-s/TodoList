import 'package:flutter/material.dart';

Widget CBottomBar(context) {
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
              onPressed: () {
                rightModalBottomSheet(context);
              }),
          IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 36,
                color: Colors.black,
              ),
              onPressed: () {
                leftModalBottomSheet(context);
              }),
        ],
      ),
    ),
    shape: CircularNotchedRectangle(),
    color: Colors.white,
  );
}

void leftModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: [
            ListTile(
              title: Text("Sort by"),
              subtitle: Text("Date"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text("Rename list"),
            ),
            Divider(),
            ListTile(
              title: Text("Delete list"),
            ),
            Divider(),
            ListTile(
              title: Text("Delete all completed tasks"),
            ),
            Divider(),
            ListTile(
              title: Text("Theme"),
              subtitle: Text("Light"),
            )
          ],
        );
      });
}

void rightModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: [
            ListTile(
              title: Text("Study"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Work"),
            ),
            ListTile(
              title: Text("Personal"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Create new list"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Help and feedback"),
            )
          ],
        );
      });
}
