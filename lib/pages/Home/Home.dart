import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'HomeBackground.dart';
import 'HomeCollapsed.dart';
import 'HomeSlider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(36.0),
      topRight: Radius.circular(36.0),
    );

    PanelController _pc = new PanelController();

    
    return Scaffold(
      body: SlidingUpPanel(
        // Config
        borderRadius: radius,
        minHeight: MediaQuery.of(context).size.height * 0.50,
        maxHeight: MediaQuery.of(context).size.height * 0.95,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        controller: _pc,

        // Main Widgets
        collapsed: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              10,
              MediaQuery.of(context).size.width * 0.05,
              0
          ),
          child: HomeCollapsed(),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: radius
          ),
        ),
        panel: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              10,
              MediaQuery.of(context).size.width * 0.05,
              0
          ),
          child: HomeSlider(),
          decoration: BoxDecoration(
              borderRadius: radius
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * 0.09,
              MediaQuery.of(context).size.width * 0.05,
              0
          ),
          child: HomeBackground(_pc)
        ),
      ),
    );
  }
}




