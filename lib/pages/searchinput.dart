import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptfabscaffold.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_query_request.dart';

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
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                autofocus: true,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 35,
                    color: Colors.grey[600]
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid
                        )
                    ),
                    labelText: "Suche"
                )
            ),
            suggestionsCallback: (pattern) async {
              return await RMVQueryRequest.getStations(pattern).catchError((e) {
                return RMVQueryRequest.failure();
              });
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Icon(Icons.place),
                title: Text(suggestion.name),
              );
            },
            onSuggestionSelected: (suggestion) {
              if(suggestion.name != "Keine Ergebnisse") {
                Navigator.of(context).pop(suggestion);
              }
            },
          ),
        )
      ),
    );
  }
}