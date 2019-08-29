import 'package:flutter/material.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/ui/animations/ScaleUp.dart';
import 'package:thepublictransport_app/pages/Home/HomeLocationShow.dart';

class HomeCollapsed extends StatefulWidget {
  @override
  _HomeCollapsedState createState() => _HomeCollapsedState();
}

class _HomeCollapsedState extends State<HomeCollapsed> {
  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(50)
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
          alignment: Alignment.centerLeft,
          child: Text(
            "In der Nähe",
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'NunitoSansSemiBold',
                color: theme.titleColor
            ),
          )
        ),
        LocationShow(),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                ScaleUp(
                  child: new Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.grey,
                  ),
                  duration: Duration(seconds: 2),
                  repeat: true,
                ),
                Text(
                  "Für mehr Funktionen, einfach nach oben wischen.",
                  style: TextStyle(
                      color: theme.subtitleColor
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}