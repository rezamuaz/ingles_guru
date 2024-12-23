import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<TestPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
          ],
        ),
      ),
   
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}