import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class show_cast_view extends StatefulWidget {
  var list1;
  show_cast_view({required this.list1});

  @override
  State<show_cast_view> createState() => _show_cast_viewState();
}

class _show_cast_viewState extends State<show_cast_view> {
  var url = "https://api.tvmaze.com/shows/";
  List<dynamic> showcastlist = [];

  var dict = {};

  @override
  void initState() {
    super.initState();
    Showcastdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: showcastlist.length,
          itemBuilder: (context, index) {
            var cast = showcastlist[index];
            var personName = cast['person']['name'];
            var characterName = cast['character']['name'];

            return Card(
              child: Column(
                children: [
                  Text('Person: $personName'),
                  Text('Character: $characterName'),
                ],
              ),
            );
          },
        ));
  }

  void Showcastdata() async {
    var id = widget.list1;
    var response = await http.get(Uri.parse('$url$id/cast'));
    setState(() {
      showcastlist = jsonDecode(response.body);
    });
  }
}
