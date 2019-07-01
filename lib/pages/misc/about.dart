import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  Widget build(BuildContext context) {
    return TPTScaffold(
      title: "Über die App",
      keyboardFocusRemove: false,
      bodyIsExpanded: true,
      hasFab: true,
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 200,
          child: Container(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: new Text("Hauptentwickler".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorThemeEngine.titleColor)),
                  subtitle: new GradientText(
                    "Tristan Marsell (PDesire)",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.grey),
                    gradient: ColorThemeEngine.tptgradient,
                  ),
                  trailing: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            EvaIcons.githubOutline,
                            color: ColorThemeEngine.iconColor,
                          ),
                          onPressed: () {
                            openURL('https://github.com/PDesire');
                          }),
                      IconButton(
                          icon: Icon(
                            EvaIcons.twitterOutline,
                            color: ColorThemeEngine.iconColor,
                          ),
                          onPressed: () {
                            openURL('https://twitter.com/PDesireDev');
                          }),
                    ],
                  ),
                ),
                ListTile(
                  title: new Text("Designer".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorThemeEngine.titleColor)),
                  subtitle: new GradientText(
                    "Anja Helena Greiß",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.grey),
                    gradient: ColorThemeEngine.tptgradient,
                  ),
                  trailing: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            EvaIcons.twitterOutline,
                            color: ColorThemeEngine.iconColor,
                          ),
                          onPressed: () {
                            openURL('https://twitter.com/anja_helena87');
                          }),
                    ],
                  ),
                ),
                ListTile(
                  subtitle: new GradientText(
                    "Yuzuki Ren",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.grey),
                    gradient: ColorThemeEngine.tptgradient,
                  ),
                ),
                ListTile(
                  title: new Text("Source Code".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorThemeEngine.titleColor)),
                  subtitle: new GradientText(
                    "GitHub",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.grey),
                    gradient: ColorThemeEngine.tptgradient,
                  ),
                  trailing: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            EvaIcons.githubOutline,
                            color: ColorThemeEngine.iconColor,
                          ),
                          onPressed: () {
                            openURL('https://github.com/thepublictransport');
                          }),
                    ],
                  ),
                ),
                ListTile(
                  title: new Text("Social Media".toUpperCase(),
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorThemeEngine.titleColor)),
                  subtitle: new GradientText(
                    "Twitter",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.grey),
                    gradient: ColorThemeEngine.tptgradient,
                  ),
                  trailing: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            EvaIcons.twitterOutline,
                            color: ColorThemeEngine.iconColor,
                          ),
                          onPressed: () {
                            openURL('https://twitter.com/OeffisFuerAlle');
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
