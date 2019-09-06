import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/backend/service/nominatim/NominatimRequest.dart';
import 'package:thepublictransport_app/framework/theme/PredefinedColors.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Delay/Delay.dart';
import 'package:thepublictransport_app/pages/Flixbus/FlixbusSearch.dart';
import 'package:thepublictransport_app/pages/ICEPortal/ICEPortal.dart';
import 'package:thepublictransport_app/pages/Settings/Settings.dart';
import 'package:thepublictransport_app/pages/Sparpreis/SparpreisSearch.dart';
import 'package:thepublictransport_app/ui/components/SelectionButtons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBackground extends StatefulWidget {
  final PanelController controller;

  HomeBackground(this.controller);

  @override
  _HomeBackgroundState createState() => _HomeBackgroundState(controller);
}

class _HomeBackgroundState extends State<HomeBackground> {
  final PanelController controller;

  var theme = ThemeEngine.getCurrentTheme();

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
              backgroundColor: theme.floatingActionButtonColor,
              elevation: 0,
              onPressed: null,
              heroTag: "HEROOOO",
              child: Icon(
                Icons.directions_bus,
                color: theme.floatingActionButtonIconColor,
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
                  fontFamily: 'NunitoBold',
                  color: theme.titleColor
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "The Public Transport",
              style: TextStyle(
                  color: theme.subtitleColor,
                  fontFamily: 'Nunito'
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return swipeMe()[index];
            },
            itemCount: 2,
            viewportFraction: 1.0,
            scale: 1.0,
            pagination: new SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  activeColor: theme.titleColor,
                  color: theme.subtitleColor
                )
            ),
          ),
        )
      ],
    );
  }

  List<Row> swipeMe() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SelectionButtons(
            gradient: Gradients.cosmicFusion,
            description: Text(
              "Suche",
              style: TextStyle(
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              Icons.search,
              color: theme.titleColorInverted,
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
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              Icons.location_on,
              color: theme.titleColorInverted,
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
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              MaterialCommunityIcons.bus_alert,
              color: theme.titleColorInverted,
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
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              Icons.settings,
              color: theme.titleColorInverted,
              size: 30,
            ),
            callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SelectionButtons(
            gradient: PredefinedColors.getDBGradient(),
            description: Text(
              "Sparpreise",
              style: TextStyle(
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              Icons.monetization_on,
              color: theme.titleColorInverted,
              size: 30,
            ),
            callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SparpreisSearch()));
            },
          ),
          SelectionButtons(
            gradient: PredefinedColors.getFlixbusGradient(),
            description: Text(
              "Flixbus Suche",
              style: TextStyle(
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              Icons.directions_bus,
              color: theme.titleColorInverted,
              size: 30,
            ),
            callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlixbusSearch()));
            },
          ),
          SelectionButtons(
            gradient: PredefinedColors.getICEGradient(),
            description: Text(
              "ICEPortal",
              style: TextStyle(
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              Icons.train,
              color: theme.titleColorInverted,
              size: 30,
            ),
            callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ICEPortal()));
            },
          ),
          SelectionButtons(
            gradient: Gradients.backToFuture,
            description: Text(
              "Sightseeing",
              style: TextStyle(
                  fontSize: 12,
                  color: theme.textColor
              ),
            ),
            icon: Icon(
              MaterialCommunityIcons.city,
              color: theme.titleColorInverted,
              size: 30,
            ),
            callback: () async {
              await sightseeingGMaps();
            },
          ),
        ],
      )
    ];
  }

  sightseeingGMaps() async {
    var coordinates = await Geocode.location();
    var nominatim = await NominatimRequest.getPlace(coordinates.latitude, coordinates.longitude);

    var url = 'https://www.google.com/maps/search/'+ nominatim.address.city + '+point+of+interest';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}