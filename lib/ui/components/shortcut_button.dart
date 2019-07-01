import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class ShortcutButton extends StatelessWidget {
  ShortcutButton(
      {@required this.title,
      @required this.icon,
      @required this.backgroundColor,
      this.onTap});

  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: onTap,
          child: Container(
            height: 100,
            width: 100,
            child: Card(
              color: backgroundColor,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Center(
                child: Icon(icon,
                    color: ColorThemeEngine.backgroundColor, size: 35),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              elevation: 0,
              margin: EdgeInsets.all(10),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        SizedBox(
          width: 95,
          height: 37,
          child: Center(
            child: new Text(
              title,
              style: new TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'NunitoSemiBold',
                  color: ColorThemeEngine.textColor),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
