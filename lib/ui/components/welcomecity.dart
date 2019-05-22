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
            borderRadius: BorderRadius.circular(25.0),
          ),
          color: Colors.white,
          child: new InkWell(
            onTap: () {
              openCity(city);
            },
            child: new Stack(
              children: <Widget>[
                getSvg(city),
                new ShowUp(
                  delay: 200,
                  child: new Center(
                    child: new Container(
                      alignment: Alignment.center,
                      child: new GradientText(
                        "Willkommen in " + city,
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

  Widget getSvg(String city) {
    if (city == "Berlin" || city == "Frankfurt")
      return SvgPicture.asset(
        'vectors/Silhouette_' + city + '.svg',
        color: Colors.grey[300],
      );
    else
      return Container();
  }

  openCity(String city) async {
    var url = "https://www.google.com/maps?q=" + city;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}