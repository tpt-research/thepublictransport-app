import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  var theme = ThemeEngine.getCurrentTheme();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: theme.backgroundColor,
      statusBarColor: Colors.transparent, // status bar color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff339999),
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff339999),
            ),
            height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
            child: Center(
              child: Text(
                allTranslations.text('ABOUT.TITLE'),
                style: TextStyle(
                    fontFamily: 'NunitoSansBold',
                    fontSize: 40,
                    color: Colors.white
                ),
              ),
            ),
          ),
          Flexible(
            child: ClipRRect(
              borderRadius: radius,
              child: Container(
                height: double.infinity,
                color: theme.backgroundColor,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars3.githubusercontent.com/u/44241397")
                              )
                          )
                      ),
                      title: Text(
                        "The Public Transport",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/thepublictransport');
                              }),
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.twitter,
                                color: Colors.lightBlueAccent,
                              ),
                              onPressed: () {
                                openURL('https://twitter.com/OeffisFuerAlle');
                              }),
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.instagram,
                                color: Colors.purpleAccent,
                              ),
                              onPressed: () {
                                openURL('https://www.instagram.com/thepublictransport/');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        allTranslations.text('ABOUT.DEVS'),
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold",
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars1.githubusercontent.com/u/20514588")
                              )
                          )
                      ),
                      title: Text(
                        "Tristan Marsell",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      subtitle: Text(
                        allTranslations.text('ABOUT.INITIATOR'),
                        style: TextStyle(
                          color: theme.subtitleColor
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/PDesire');
                              }),
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.twitter,
                                color: Colors.lightBlueAccent,
                              ),
                              onPressed: () {
                                openURL('https://twitter.com/PDesireDev');
                              }),
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.instagram,
                                color: Colors.purpleAccent,
                              ),
                              onPressed: () {
                                openURL('https://www.instagram.com/pdesire_chan/');
                              }),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "icons/anja.png"
                                  )
                              )
                          )
                      ),
                      title: Text(
                        "Anja Greiß",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      subtitle: Text(
                        allTranslations.text('ABOUT.DESIGN_HELP'),
                        style: TextStyle(
                            color: theme.subtitleColor
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.twitter,
                                color: Colors.lightBlueAccent,
                              ),
                              onPressed: () {
                                openURL('https://twitter.com/anja_helena87');
                              }),
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.instagram,
                                color: Colors.purpleAccent,
                              ),
                              onPressed: () {
                                openURL('https://www.instagram.com/anja_helena87');
                              }),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars2.githubusercontent.com/u/28508724")
                              )
                          )
                      ),
                      title: Text(
                        "Tim (CodeNameT1M)",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      subtitle: Text(
                        allTranslations.text('ABOUT.DEVOPS'),
                        style: TextStyle(
                            color: theme.subtitleColor
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/CodeNameT1M');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        allTranslations.text('ABOUT.THANKS_TO'),
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold",
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars1.githubusercontent.com/u/743306")
                              )
                          )
                      ),
                      title: Text(
                        "Andreas Schildbach",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/schildbach');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars0.githubusercontent.com/u/1584289")
                              )
                          )
                      ),
                      title: Text(
                        "Julius Tens",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/juliuste');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars1.githubusercontent.com/u/5072613")
                              )
                          )
                      ),
                      title: Text(
                        "Jannis Redmann",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/derhuerst');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars2.githubusercontent.com/u/97706")
                              )
                          )
                      ),
                      title: Text(
                        "Felix Delattre",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/xamanu');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars2.githubusercontent.com/u/244947")
                              )
                          )
                      ),
                      title: Text(
                        "Torsten Grote & Transportr",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/grote');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars1.githubusercontent.com/u/14101776")
                              )
                          )
                      ),
                      title: Text(
                        "Flutter",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/flutter');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://avatars0.githubusercontent.com/u/878437")
                              )
                          )
                      ),
                      title: Text(
                        "JetBrains",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://github.com/JetBrains');
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://assets.gitlab-static.net/uploads/-/system/project/avatar/7507693/ic_oeffi_stations_color_48dp.png")
                              )
                          )
                      ),
                      title: Text(
                        "Öffi",
                        style: TextStyle(
                            color: theme.titleColor,
                            fontFamily: "NunitoSansBold"
                        ),
                      ),
                      trailing: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                MaterialCommunityIcons.github_circle,
                                color: theme.iconColor,
                              ),
                              onPressed: () {
                                openURL('https://gitlab.com/oeffi/oeffi');
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
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
