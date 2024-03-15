import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machinetest/showcast.dart';

class Show_View extends StatefulWidget {
  var list1;

  Show_View({required this.list1});

  @override
  State<Show_View> createState() => _Show_ViewState();
}

class _Show_ViewState extends State<Show_View> {
  var url = "https://api.tvmaze.com/shows";
  var dic1 = {};
  List<dynamic> dataList = [];
  var dic2 = {};
  var id;

  @override
  void initState() {
    super.initState();
    GetShowSingleView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Name :" + dic1['name']),
            Text("Type :" + dic1['type']),
            Text("Language :" + dic1['language']),
            Text("status :" + dic1['status']),
            for (int i = 0; i < dataList.length; i++) Text(dataList[i]),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => show_cast_view(list1: id)),
                  );
                },
                child: Text("SHOW CAST"))
          ],
        ),
      ),
    );
  }

  void GetShowSingleView() async {
    id = int.parse(widget.list1["id"].toString());
    print(id);
    var response = await http.get(Uri.parse('$url/$id'));

    setState(() {
      dic1 = jsonDecode(response.body);
      print(dic1);

      dataList = dic1['genres'];
    });
  }
}
