import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class TPTScaffold extends StatefulWidget {
  TPTScaffold(
      {this.body,
      this.title,
      this.bodyIsExpanded,
      this.keyboardFocusRemove,
      this.hasFab,
      this.isFabVisible,
      this.customFab});

  final Widget body;
  final String title;
  final bool bodyIsExpanded;
  final bool keyboardFocusRemove;
  final bool hasFab;
  final bool isFabVisible;
  final Widget customFab;

  @override
  _TPTScaffoldState createState() => _TPTScaffoldState(
      this.body,
      this.title,
      this.bodyIsExpanded,
      this.keyboardFocusRemove,
      this.hasFab,
      this.customFab);
}

class _TPTScaffoldState extends State<TPTScaffold> {
  _TPTScaffoldState(this.body, this.title, this.bodyIsExpanded,
      this.keyboardFocusRemove, this.hasFab, this.customFab);

  final Widget body;
  final String title;
  final bool bodyIsExpanded;
  final bool keyboardFocusRemove;
  final bool hasFab;
  final Widget customFab;

  bool isFabVisible = true;

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorThemeEngine.backgroundColor,
      floatingActionButton: new ShowUp(delay: 500, child: _hasFab()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 0,
              color: ColorThemeEngine.backgroundColor,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(
                    height: MediaQuery.of(context).padding.top + 15,
                  ),
                  new ShowUp(
                    delay: 400,
                    child: new Container(
                      padding: EdgeInsets.only(left: 15),
                      child: new Text("The Public Transport".toUpperCase(),
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorThemeEngine.titleColor,
                              fontFamily: 'NunitoSemiBold')),
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
                              color: Colors.grey,
                              fontFamily: 'NunitoSemiBold'),
                          gradient: ColorThemeEngine.tptgradient),
                    ),
                  ),
                  new SizedBox(
                    height: 15,
                  )
                ],
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
    if (customFab != null) {
      return customFab;
    }
    if (hasFab)
      return new ShowUp(
        delay: 500,
        child: AnimatedOpacity(
          opacity: isFabVisible ? 1.0 : 0.3,
          duration: Duration(milliseconds: 300),
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
      );
    else
      return Container();
  }
}
