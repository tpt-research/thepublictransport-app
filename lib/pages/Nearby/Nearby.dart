import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:preferences/preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Nearby/NearbyCollapsed.dart';
import 'package:thepublictransport_app/pages/Nearby/NearbySlider.dart';
import 'package:thepublictransport_app/pages/Station/Station.dart';
import 'package:thepublictransport_app/ui/components/Maps/MapsStops.dart';

class Nearby extends StatefulWidget {
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            minHeight: MediaQuery.of(context).size.height * 0.34,
            maxHeight: MediaQuery.of(context).size.height * 0.50,
            borderRadius: radius,
            panel: Container(
                decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: radius
                ),
                child: NearbySlider()
            ),
            collapsed: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: radius
              ),
              child: NearbyCollapsed()
            ),
            body: Stack(
              children: <Widget>[
                MapsStops(),
                Container(
                  padding: EdgeInsets.fromLTRB(5, MediaQuery.of(context).padding.top + 10, 5, 0),
                  child: Card(
                    color: theme.backgroundColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: TypeAheadField(
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                      ),
                      textFieldConfiguration: TextFieldConfiguration(
                          autofocus: false,
                          autocorrect: true,
                          style: TextStyle(
                              fontSize: 18,
                              color: theme.textColor
                          ),
                          decoration: InputDecoration(
                            hintText: allTranslations.text('NEARBY.SEARCH'),
                            hintStyle: TextStyle(
                              color: theme.textColor
                            ),
                            alignLabelWithHint: true,
                            prefixIcon: Icon(
                              Icons.search,
                              color: theme.iconColor,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                              child: ClipOval(
                                child: Material(
                                  color: theme.iconColor, // button color
                                  child: InkWell(
                                    splashColor: theme.iconColor, // inkwell color
                                    child: SizedBox(width: 20, height: 20, child: Icon(Icons.directions_bus, color: theme.backgroundColor)),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                          )
                      ),
                      suggestionsCallback: (pattern) async {
                        return await getResults(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return Container(
                          color: theme.foregroundColor,
                          child: ListTile(
                            leading: Icon(Icons.location_on, color: theme.iconColor),
                            title: Text(
                              suggestion.location.name + (suggestion.location.place != null ? ", " + suggestion.location.place : ""),
                              style: TextStyle(
                                  color: theme.textColor
                              ),
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) async {
                        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Station(suggestion.location)));
                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                          systemNavigationBarColor: Colors.blueAccent,
                          statusBarColor: Colors.transparent, // status bar color
                          statusBarBrightness: Brightness.light,
                          statusBarIconBrightness: Brightness.light,
                        ));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.black.withAlpha(120),
          ),
        ],
      ),
    );
  }

  Future<List<SuggestedLocation>> getResults(String query) async {
    var result = await CoreService.getLocationQuery(query, "STATION", PrefService.getBool("datasave_mode") == false ? 10.toString() : 5.toString(), PrefService.getString('public_transport_data'));

    return result.suggestedLocations;
  }
}
