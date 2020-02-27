import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {

  @override
  State createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  List data;

  Future<void> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );
    
    this.setState(() {
      data = jsonDecode(response.body);
    });
    
    print(data[1]["title"]);
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: data == null? 0: data.length,
        itemBuilder: (BuildContext context, int index) {
          if(index.isOdd) {
            return Divider();
          }

          return ListTile(
            title: Text(
              data[index >> 1]["title"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          );
        }
      ),
    );
  }
}