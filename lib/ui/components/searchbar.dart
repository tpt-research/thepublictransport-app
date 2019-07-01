import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class Searchbar extends StatelessWidget {
  Searchbar({this.text, this.onTap, this.onButtonPressed});

  final String text;
  final Function onTap;
  final Function onButtonPressed;

  Widget build(BuildContext context) {
    return new Card(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: new BorderSide(width: 0.5, color: Colors.grey)),
        elevation: 0,
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        color: ColorThemeEngine.backgroundColor,
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
                              fontFamily: 'Nunito',
                              fontSize: 17,
                              color: ColorThemeEngine.subtitleColor)),
                      new Container(
                        child: IconButton(
                            icon: Icon(Icons.my_location,
                                color: ColorThemeEngine.iconColor),
                            onPressed: onButtonPressed),
                      )
                    ],
                  )),
            )));
  }
}
