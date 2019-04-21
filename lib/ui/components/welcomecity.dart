import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';

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
          child: new Stack(
            children: <Widget>[
              SvgPicture.asset(
                'vectors/Silhouette_' + city + '.svg',
                color: Colors.grey[300],
              ),
              new Center(
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
              )
            ],
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
}