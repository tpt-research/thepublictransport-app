import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptsearchscaffold.dart';

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
        child: new Text('test'),
      ),
    );
  }
}