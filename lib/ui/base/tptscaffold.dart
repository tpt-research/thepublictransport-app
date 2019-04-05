import 'package:flutter/material.dart';

class TPTScaffold extends StatefulWidget {
  TPTScaffold({this.body});

  final Widget body;

  @override
  _TPTScaffoldState createState() => _TPTScaffoldState(this.body);
}

class _TPTScaffoldState extends State<TPTScaffold> {
  _TPTScaffoldState(this.body);

  final Widget body;

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: body
    );
  }
}