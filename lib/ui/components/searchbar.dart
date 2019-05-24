import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';

class Searchbar extends StatelessWidget {
  Searchbar({this.text, this.onTap, this.onButtonPressed});

  final String text;
  final Function onTap;
  final Function onButtonPressed;

  Widget build(BuildContext context) {
    return new Card(
      shape: new StadiumBorder(
        side: new BorderSide(
          width: 2.0,
          color: ColorConstants.textColor
        )
      ),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      color: ColorConstants.backgroundColor,
      child: SizedBox(
          height: 50,
          child: InkWell(
            onTap: onTap,
            child: new Container(
                padding: EdgeInsets.only(left: 17),
                child : new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                        this.text,
                        style: new TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                            color: ColorConstants.subtitleColor
                        )
                    ),
                    new Container(
                      child: IconButton(
                          icon: Icon(Icons.my_location, color: ColorConstants.iconColor),
                          onPressed: onButtonPressed
                      ),
                    )
                  ],
                )
            ),
          )
      )
    );
  }
}