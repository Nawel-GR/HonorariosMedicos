import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aqui tenemos que poner lo de arriva'),
      ),
      body: Column
      (
        children: 
        [
          InkWell(
            onTap: ()
            {
            },
            child: Container
            (
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration
              (
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Go to About', style: TextStyle(color: Colors.white),),
            ),
          ),
          
          HonorButton(
            text: 'Go to About',
            onTap: ()
            {
            },
          ),
          HonorButton(
            text: 'Go to Contact',
            onTap: ()
            {
              
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children:[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              title: Text('Contact'),
              onTap: () {
                Navigator.pushNamed(context, '/contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}