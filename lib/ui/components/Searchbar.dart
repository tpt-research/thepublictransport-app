import 'package:flutter/material.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';

class Searchbar extends StatelessWidget {
  Searchbar({this.text, this.onTap, this.onButtonPressed});

  final String text;
  final Function onTap;
  final Function onButtonPressed;

  final theme = ThemeEngine.getCurrentTheme();

  Widget build(BuildContext context) {
    return new Card(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: new BorderSide(width: 0, color: Colors.transparent)
        ),
        elevation: 0,
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        color: theme.backgroundColor,
        child: SizedBox(
            height: 50,
            child: InkWell(
              onTap: onTap,
              child: new Container(
                  padding: EdgeInsets.only(left: 17),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(this.text,
                          overflow: TextOverflow.fade,
                          style: new TextStyle(
                              fontSize: 17,
                              color: theme.subtitleColor)),
                      new Container(
                        child: IconButton(
                            icon: Icon(Icons.my_location,
                                color: theme.iconColor),
                            onPressed: onButtonPressed),
                      )
                    ],
                  )
              ),
            )
        )
    );
  }
}
