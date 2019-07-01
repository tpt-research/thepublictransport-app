import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class TPTScaffold extends StatefulWidget {
  TPTScaffold({this.body, this.title, this.bodyIsExpanded, this.keyboardFocusRemove, this.hasFab});

  final Widget body;
  final String title;
  final bool bodyIsExpanded;
  final bool keyboardFocusRemove;
  final bool hasFab;

  @override
  _TPTScaffoldState createState() => _TPTScaffoldState(this.body, this.title, this.bodyIsExpanded, this.keyboardFocusRemove, this.hasFab);
}

class _TPTScaffoldState extends State<TPTScaffold> {
  _TPTScaffoldState(this.body, this.title, this.bodyIsExpanded, this.keyboardFocusRemove, this.hasFab);

  final Widget body;
  final String title;
  final bool bodyIsExpanded;
  final bool keyboardFocusRemove;
  final bool hasFab;

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorThemeEngine.backgroundColor,
      floatingActionButton: new ShowUp(
        delay: 500,
        child: new CircularGradientButton(
          gradient: ColorThemeEngine.tptfabgradient,
          child: Icon(Icons.arrow_back),
          callback: () {
            if (keyboardFocusRemove)
              FocusScope.of(context).requestFocus(new FocusNode());

            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: new Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).padding.left,
            MediaQuery.of(context).padding.top + 15,
            MediaQuery.of(context).padding.right,
            MediaQuery.of(context).padding.bottom),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new ShowUp(
              delay: 400,
              child: new Container(
                padding: EdgeInsets.only(left: 15),
                child: new Text("The Public Transport".toUpperCase(),
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: ColorThemeEngine.titleColor)),
              ),
            ),
            new ShowUp(
              delay: 800,
              child: new Container(
                padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                child: new GradientText(title,
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: Colors.grey),
                    gradient: ColorThemeEngine.tptgradient),
              ),
            ),
            _isExpanded()
          ],
        ),
      ),
    );
  }

  Widget _isExpanded() {
    return bodyIsExpanded ? Expanded(child: body) : body;
  }

  Widget _hasFab() {
    if (hasFab)
      return new ShowUp(
        delay: 500,
        child: new CircularGradientButton(
          gradient: ColorThemeEngine.tptfabgradient,
          child: Icon(Icons.arrow_back),
          callback: () {
            if (keyboardFocusRemove)
              FocusScope.of(context).requestFocus(new FocusNode());

            Navigator.of(context).pop();
          },
        ),
      );
    else
      return Container();
  }
}
