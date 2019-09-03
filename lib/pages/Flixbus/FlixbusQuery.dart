import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/backend/models/flixbus/QueryResult.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/backend/service/flixbus/FlixbusService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/ui/components/Maps/MapsOverlay.dart';

class FlixbusQuery extends StatefulWidget {
  @override
  _FlixbusQueryState createState() => _FlixbusQueryState();
}

class _FlixbusQueryState extends State<FlixbusQuery> {
  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      body: Stack(
        children: <Widget>[
          MapsOverlay(),
          Container(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.10, 20, 0),
            child: Card(
              color: theme.foregroundColor,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: new BorderSide(width: 0, color: Colors.transparent)
              ),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: theme.status == "light" ? false : true,
                    autocorrect: true,
                    style: TextStyle(
                      fontSize: 20,
                      color: theme.textColor
                    ),
                    decoration: InputDecoration(
                        labelText: 'Suche',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        fillColor: theme.textColor,
                    )
                ),
                suggestionsCallback: (pattern) async {
                  return await getResults(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return Container(
                    color: theme.foregroundColor,
                    child: ListTile(
                      leading: Icon(decideIcon(suggestion.type), color: theme.iconColor),
                      title: Text(
                          suggestion.name,
                          style: TextStyle(
                            color: theme.textColor
                          ),
                      ),
                    ),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  Navigator.of(context).pop(suggestion);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  IconData decideIcon(String mode) {
    if (mode == "region")
      return Icons.location_city;
    
    return Icons.location_on;
  }

  Future<List<QueryResult>> getResults(String query) async {
    var result = await FlixbusService.getQuery(query, PrefService.getBool("datasave_mode") == false ? 5 : 2);

    return result.queryResult;
  }
}
