import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class SearchbarDummy extends StatelessWidget {
  SearchbarDummy({this.text, this.onTap});

  final String text;
  final Function onTap;

  Widget build(BuildContext context) {
    return new Card(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: new BorderSide(width: 0.0, color: Colors.transparent)),
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 15),
        color: ColorThemeEngine.backgroundColor,
        child: SizedBox(
            height: 50,
            child: InkWell(
              onTap: onTap,
              child: new Container(
                  padding: EdgeInsets.only(left: 17),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(left: 0.5),
                        child: IconButton(
                          icon: Icon(Icons.search,
                              color: ColorThemeEngine.iconColor),
                          onPressed: onTap,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: new Text(this.text,
                            style: new TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 17,
                                color: ColorThemeEngine.subtitleColor)),
                      ),
                    ],
                  )),
            )));
  }
}
