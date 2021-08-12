import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.dev/api/people";
  List data = [];

  Future<String> getJsonData() async {
    var response = await http.get(
        //Encode the url
        Uri.parse(url),
        //only accept json respose
        headers: {"Accept": "application/json"});
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
      print(data);
    });

    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http json Fatch"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      child: Text(data[i]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
