import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/backend/service/nominatim/NominatimRequest.dart';
import 'package:thepublictransport_app/framework/theme/PredefinedColors.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Delay/Delay.dart';
import 'package:thepublictransport_app/pages/SavedTrips/SavedTrips.dart';
import 'package:thepublictransport_app/pages/Sparpreis/SparpreisSearch.dart';
import 'package:thepublictransport_app/ui/components/SelectionButtons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCollapsed extends StatefulWidget {
  @override
  _HomeCollapsedState createState() => _HomeCollapsedState();
}

class _HomeCollapsedState extends State<HomeCollapsed> {
  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
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
            SizedBox(
              height: 20,
            ),
            Text(
              "Erkunden Sie die Welt!",
              style: TextStyle(
                fontSize: 20,
                color: theme.textColor
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SelectionButtons(
                  gradient: Gradients.jShine,
                  description: Text(
                    "Gespeichert",
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.textColor
                    ),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: theme.titleColorInverted,
                    size: 30,
                  ),
                  callback: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavedTrips()));
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
              ],
            ),
          ]
      ),
    );
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
