import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(  
      child: ListView(  
        padding: EdgeInsets.zero,  
        children: <Widget>[  
          const DrawerHeader(  
            decoration: BoxDecoration(  
              color: Colors.blue,  
            ),  
            child: Text('Drawer Header'),  
          ),  
          ListTile(  
            title: Text('stopTimer'.tr),  
            onTap: () { 
              
            },  
          ), 
        ],  
      ),  
    );  
  }
}