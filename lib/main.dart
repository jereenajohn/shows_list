import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machinetest/showcast.dart';
import 'package:machinetest/showview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp1(),
    );
  }
}

class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  var url = "https://api.tvmaze.com/shows";
  List<dynamic> showlist = [];
  var dic = {};

  @override
  void initState() {
    getshowdata(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIST OF SHOWS"),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: showlist.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> dic = showlist[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Show_View(list1: showlist[index])));
            },
            child: Card(
              child: Column(
                children: [
                  Text("Show Name :" + dic['name']),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void getshowdata(var url) async {
    var response = await http.get(Uri.parse(url));

    setState(() {
      showlist = jsonDecode(response.body);
    });
  }
}
