

import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thepublictransport_app/pages/Delay/Delay.dart';
import 'package:thepublictransport_app/pages/Settings/Settings.dart';
import 'package:thepublictransport_app/ui/components/SelectionButtons.dart';

class HomeBackground extends StatefulWidget {
  final PanelController controller;

  HomeBackground(this.controller);

  @override
  _HomeBackgroundState createState() => _HomeBackgroundState(controller);
}

class _HomeBackgroundState extends State<HomeBackground> {
  final PanelController controller;

  _HomeBackgroundState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.black,
              elevation: 0,
              onPressed: null,
              heroTag: "HEROOOO",
              child: Icon(
                Icons.directions_bus,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Willkommen zurück !",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'NunitoBold'
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "The Public Transport",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Nunito'
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SelectionButtons(
              gradient: Gradients.cosmicFusion,
              description: Text(
                  "Suche",
                  style: TextStyle(
                    fontSize: 12
                  ),
              ),
              icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
              ),
              callback: () {
                controller.open();
              },
            ),
            SelectionButtons(
              gradient: Gradients.jShine,
              description: Text(
                  "Haltestellen",
                style: TextStyle(
                    fontSize: 12
                ),
              ),
              icon: Icon(
                Icons.location_on,
                color: Colors.white,
                size: 30,
              ),
              callback: () {
                controller.open();
              },
            ),
            SelectionButtons(
              gradient: Gradients.rainbowBlue,
              description: Text(
                  "Verspätungen",
                style: TextStyle(
                    fontSize: 12
                ),
              ),
              icon: Icon(
                Icons.timer,
                color: Colors.white,
                size: 30,
              ),
              callback: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Delay()));
              },
            ),
            SelectionButtons(
              gradient: Gradients.coldLinear,
              description: Text(
                  "Einstellungen",
                style: TextStyle(
                    fontSize: 12
                ),
              ),
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              callback: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ],
        )
      ],
    );
  }
}