import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptsearchscaffold.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_query_request.dart';
import 'package:thepublictransport_app/pages/nearby_search_result.dart';

class NearbySearchPage extends StatefulWidget {
  @override
  _NearbySearchPage createState() => _NearbySearchPage();
}

class _NearbySearchPage extends State<NearbySearchPage> {
  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: "Suche in der Nähe",
      body: new Container(
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
                  )
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NearbySearchResultPage(suggestion)));
            }
          },
        ),
      ),
    );
  }
}