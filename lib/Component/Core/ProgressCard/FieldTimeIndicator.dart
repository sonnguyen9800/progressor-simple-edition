import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Utils/Define.dart';
import 'package:progressor/Utils/UtilsMethod.dart';

class FieldTimeIndicator extends StatefulWidget {
  @required int time;
  @required Progress progress;
  FieldTimeIndicator ({Key key, this.progress, this.time}) : super(key : key);
  @override
  _FieldTimeIndicatorState createState() => _FieldTimeIndicatorState();
}

class _FieldTimeIndicatorState extends State<FieldTimeIndicator> {
  @override
  Widget build(BuildContext context) {
    return Text(
        _updateTimeText(widget.progress, widget.time),
      style: GoogleFonts.robotoCondensed(
        fontWeight: FontWeight.bold,
        color: AppColors.PRIMARY_COLOR,
        fontSize: AppDimension.SMALL_SIZE,

      ),
    );
  }

  String _updateTimeText(Progress progress, int _currentSecond) {
    String textReturned;

    if (_currentSecond > progress.totalSecond) {
      textReturned =
          "+" + Utils.FromSecondToTextTime(_currentSecond - progress.totalSecond);
    } else {
      textReturned =
          Utils.FromSecondToTextTime(progress.totalSecond - _currentSecond) + "s LEFT";
    }
    return textReturned;

  }
}

