import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/components/searchbar.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:thepublictransport_app/pages/loadscreen.dart';
import 'package:thepublictransport_app/ui/components/mapswidget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).padding.left,
            0,
            MediaQuery.of(context).padding.right,
            MediaQuery.of(context).padding.bottom
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                new SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: new MapsWidget()
                ),
                new Center(
                  child: new Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
                    child: new SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.54,
                      child: new Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                width: 0,
                                color: Colors.black
                            )
                        ),
                        color: Colors.white,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Searchbar(
                              text: "Start",
                            ),
                            new Searchbar(
                              text: "Ziel",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                new Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.69,
                      MediaQuery.of(context).size.width * 0.14,
                      0
                  ),
                  child: new CircularGradientButton(
                      gradient: ColorConstants.tptfabgradient,
                      child: new Icon(
                          Icons.search
                      ),
                      callback: (){}
                  ),
                )
              ]
            )
          ],
        ),
      ),
    );
  }

  onSubmit(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoadScreenWidget()
        )
    );
  }
}