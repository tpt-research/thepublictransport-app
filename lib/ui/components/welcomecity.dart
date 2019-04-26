import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';

class WelcomeCity extends StatefulWidget {
  WelcomeCity({@required this.city});
  
  final String city;
  
  @override
  _WelcomeCityState createState() => _WelcomeCityState(this.city);
}

class _WelcomeCityState extends State<WelcomeCity> {
  _WelcomeCityState(this.city);

  final String city;
  
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 10),
      child: new SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
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
          child: new InkWell(
            onTap: () {
              openCity(city);
            },
            child: new Stack(
              children: <Widget>[
                SvgPicture.asset(
                  'vectors/Silhouette_' + city + '.svg',
                  color: Colors.grey[300],
                ),
                new ShowUp(
                  delay: 200,
                  child: new Center(
                    child: new Container(
                      alignment: Alignment.center,
                      child: new GradientText(
                        resolveGreetings(city),
                        gradient: ColorConstants.tptgradient,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  String resolveGreetings(String city) {
    switch (city) {
      case "Berlin":
        return "Wilkommen in Berlin";
        
      case "Frankfurt":
        return "Wilkommen in Frankfurt am Main";
    }
  }

  openCity(String city) async {
    var url = "";
    switch (city) {
      case "Berlin":
        url = "https://www.google.com/maps?q=Berlin";
        break;

      case "Frankfurt":
        url = "https://www.google.com/maps?q=Frankfurt%20am%20Main";
        break;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}