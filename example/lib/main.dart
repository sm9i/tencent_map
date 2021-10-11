import 'package:flutter/material.dart';

import 'package:tencent_map_example/page/map_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            title: Text('go map '),
            onTap: () async {
              // print(await  Permission.phone.isGranted);
              // print(await  Permission.storage.isGranted);
              // print(await  Permission.location.isGranted);
              // Permission.location.request();
              // Permission.storage.request();
              // Permission.location.request();
              // Permission.phone.request();
              // [Permission.location, Permission.phone].request();
              Navigator.push(context, MaterialPageRoute(builder: (_) => MapViewPage()));
            },
          ),

        ],
      ),
    );
  }
}

