import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/side_drawer.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final double selectedItem; // TODO: change this to a list of tabs

  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          PopupMenuButton(
            icon: Icon(CupertinoIcons.person),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    // Add your onPressed function here
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                  onTap: () {
                    // Add your onPressed function here
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: body,
      drawer: SideDrawer(),
    );
  }
}
