import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/detail.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/theme/honor_theme.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: HonorTheme.colors.primary,
            ),
            child: Text(
              'HonorMed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              // Handle drawer item tap
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.money_dollar_circle_fill),
            title: Text('Detalle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle drawer item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Handle drawer item tap
            },
          ),
        ],
      ),
    );
  }
}
