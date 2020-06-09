import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double value;

  LoadingContainer({
    Key key,
    this.color,
    this.strokeWidth = 5.0,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: strokeWidth,
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? Theme.of(context).accentColor,
      ),
    );
  }
}
