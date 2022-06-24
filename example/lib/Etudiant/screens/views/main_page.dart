import 'dart:convert';

import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/editpage.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/welcome_page.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/settings_page.dart';
import 'package:arcore_flutter_plugin_example/utils.dart';
import 'package:arcore_flutter_plugin_example/utils_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:arcore_flutter_plugin_example/Etudiant/screens/views/screen_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Text("Espace Etudiant"),)
            
        
    );
  }
}
