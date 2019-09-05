import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';

class FlareScaffoldBackground extends StatefulWidget {
  @override
  _FlareScaffoldBackgroundState createState() => _FlareScaffoldBackgroundState();
}

class _FlareScaffoldBackgroundState extends State<FlareScaffoldBackground> {

  var theme = ThemeEngine.getCurrentTheme();
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: actor,
    );
  }

  Widget get actor {
    if (theme.status == "dark")
      return Container(
        child: FlareActor(
            'anim/dark_background.flr',
            alignment: Alignment.center,
            fit: BoxFit.fill,
            animation: 'Untitled'
        ),
      );
    
    return Container(
      child: Stack(
        children: <Widget>[
          FlareActor(
              'anim/light_background.flr',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              animation: 'peace'
          ),
          Container(
            color: Colors.white.withAlpha(200),
          )
        ],
      ),
    );
  }
}
