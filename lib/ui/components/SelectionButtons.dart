import 'package:flutter/material.dart';

class SelectionButtons extends StatelessWidget {
  final Color color;
  final Icon icon;
  final Text description;
  final Function callback;

  SelectionButtons({this.color, this.icon, this.description, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: callback,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.height * 0.09,
            child: Card(
              color: color,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)
              ),
              child: Center(
                child: icon,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        description
      ],
    );
  }
}
