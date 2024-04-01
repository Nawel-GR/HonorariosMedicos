import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/side_drawer.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/circular_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
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
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: HonorTheme.colors.primaryLight,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EasyRichText(
                  'Por pagar: \$100.000 CLP',
                  defaultStyle: HonorTypography.body,
                  patternList: [
                    EasyRichTextPattern(
                      targetString: '\$100.000',
                      style: TextStyle(
                        color: HonorTheme.colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Center(
              child: CircularIconButton(
            icon: CupertinoIcons.cloud_upload,
            onPressed: () {},
            color: HonorTheme.colors.primaryLight,
            size: 390,
          )),
          SizedBox(height: 50),
          Container(
            height: MediaQuery.of(context).size.height * 0.252,
            alignment: Alignment.bottomLeft,
            color: HonorTheme.colors.primaryLight,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: HonorButton(
                    buttonSize: ButtonSize.large,
                    text: 'Estado de pagos',
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: HonorButton(
                    buttonSize: ButtonSize.large,
                    text: 'Tracking',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: SideDrawer(),
    );
  }
}
