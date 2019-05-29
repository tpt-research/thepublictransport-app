import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptfabscaffold.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_query_request.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class SearchInput extends StatefulWidget {
  SearchInput({@required this.title, @required this.mode});

  final String title;
  final int mode;

  @override
  _SearchInputState createState() => _SearchInputState(title, mode);
}

class _SearchInputState extends State<SearchInput> {
  _SearchInputState(this.title, this.mode);

  final String title;
  final int mode;

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: title,
      body: new Container(
        child: new Container(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: ColorThemeEngine.decideBorderSide()
            ),
            color: ColorThemeEngine.cardColor,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    autocorrect: true,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: ColorThemeEngine.subtitleColor,
                    ),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            borderSide: ColorThemeEngine.decideBorderSide()

                        ),
                        labelText: "Suche...",
                        labelStyle: new TextStyle(
                          color: ColorThemeEngine.textColor
                        ),
                    )
                ),
                suggestionsCallback: (pattern) async {
                  return await RMVQueryRequest.getIntelligentStations(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return Container(
                    color: ColorThemeEngine.backgroundColor,
                    child: ListTile(
                      leading: Icon(Icons.place, color: ColorThemeEngine.iconColor),
                      title: Text(
                          suggestion.name,
                          style: new TextStyle(
                            color: ColorThemeEngine.textColor
                          ),
                      ),
                    ),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  if(suggestion.name != "Keine Ergebnisse") {
                    Navigator.of(context).pop(suggestion);
                  }
                },
              ),
            ),
          ),
        )
      ),
    );
  }
}