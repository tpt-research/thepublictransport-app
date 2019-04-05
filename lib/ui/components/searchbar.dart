import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  Searchbar({this.text, this.onClick, this.onSubmit});

  final String text;
  final Function onClick;
  final Function onSubmit;


  @override
  _SearchbarState createState() => _SearchbarState(this.text, this.onClick, this.onSubmit);
}

class _SearchbarState extends State<Searchbar> {
  _SearchbarState(this.text, this.onClick, this.onSubmit);

  final String text;
  final Function onClick;
  final Function onSubmit;


  Widget build(BuildContext context) {
    return new Card(
      shape: StadiumBorder(side: BorderSide(width: 2.0)),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SizedBox(
          height: 50,
          child: new Container(
              padding: EdgeInsets.only(left: 17),
              child : new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(
                      this.text,
                      style: new TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17
                      )
                  )
                ],
              )
          )
      ),
    );
  }
}