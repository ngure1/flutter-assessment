import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [Text("Link 1"), Text("Link 2"), Text("Link 3")]),
    );
  }
}