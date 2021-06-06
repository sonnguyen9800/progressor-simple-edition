import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Component/Core/ProgressCard/ProgressItemControlView.dart';
import 'package:progressor/Utils/Define.dart';

class FieldStatusIndicator extends StatefulWidget {

  @required ProgressState progressState;
  FieldStatusIndicator({ Key Key, this.progressState  }) : super (key: Key);

  @override
  _FieldStatusIndicatorState createState() => _FieldStatusIndicatorState();
}

class _FieldStatusIndicatorState extends State<FieldStatusIndicator> {
  String _text = "";
  @override
  Widget build(BuildContext context) {

    switch(widget.progressState){
      case (ProgressState.NOT_FINISH):
        _text = "Start?";
        break;
      case (ProgressState.ON_GOING):
        _text = "Working";
        break;
      case (ProgressState.FINISH):
        _text = "Finished";
        break;
      default:
        _text = "Unknown State";
        break;

    }


    return Text(
      _text,
      style: GoogleFonts.shareTech(
        fontWeight: FontWeight.bold,
        color: AppColors.ACCENT_COLOR,
        fontSize: AppDimension.MEDIUM_SIZE,

      ),
    );

  }
}
