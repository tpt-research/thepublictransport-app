

import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
              description: Text("Suche"),
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
              description: Text("Haltestellen"),
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
              description: Text("Bewerten"),
              icon: Icon(
                Icons.star,
                color: Colors.white,
                size: 30,
              ),
            ),
            SelectionButtons(
              gradient: Gradients.coldLinear,
              description: Text("Einstellungen"),
              icon: Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        )
      ],
    );
  }
}