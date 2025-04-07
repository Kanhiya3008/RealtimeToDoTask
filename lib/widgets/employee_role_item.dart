import 'package:flutter/material.dart';

Widget buildMenuItem(BuildContext context, String title, bool isLast) {
  return Column(
    children: [
      ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onTap: () => Navigator.pop(context),
      ),
      if (!isLast)
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[300],
          indent: 16,
          endIndent: 16,
        ),
    ],
  );
}

final List<String> menuItems = [
  "Product Designer",
  "Flutter Developer",
  "QA Tester",
  "Product Owner",
];
