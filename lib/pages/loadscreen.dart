import 'package:flutter/material.dart';

class LoadScreenWidget extends StatefulWidget {
  @override
  _LoadScreenWidgetState createState() => _LoadScreenWidgetState();
}

class _LoadScreenWidgetState extends State<LoadScreenWidget> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 50, 0, 0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Text("Schon gewusst ?",
            style: new TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
              fontFamily: 'Raleway-Bold'
                ),
            )
          ],
        ),
      ),
    );
  }
}