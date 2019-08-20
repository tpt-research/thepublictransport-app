import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class SelectionButtons extends StatelessWidget {
  final Gradient gradient;
  final Icon icon;
  final Text description;
  final Function callback;

  SelectionButtons({this.gradient, this.icon, this.description, this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: callback,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.height * 0.09,
            child: GradientCard(
              gradient: gradient,
              shadowColor: gradient.colors.last.withOpacity(0.25),
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
