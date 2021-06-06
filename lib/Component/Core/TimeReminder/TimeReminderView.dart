import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Model/SupportModel/WeekTime.dart';
import 'package:progressor/Utils/Define.dart';

class TimeReminderView extends StatefulWidget {
  @required
  final WeekTime weekTime;
  TimeReminderView({Key key, this.weekTime});
  @override
  _TimeReminderViewState createState() => _TimeReminderViewState();
}


class _TimeReminderViewState extends State<TimeReminderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      child: Container(
          color: AppColors.ACCENT_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Text(
                  widget.weekTime.toString(),
                  style: GoogleFonts.robotoMono(),
                ),
                flex: 7,
              ),
              Flexible(
                child: Material(
                  color: AppColors.ACCENT_COLOR,
                  child: IconButton(
                    onPressed: () {
                      print("Delete the time reminder");
                    },
                    alignment: Alignment.center,
                    splashColor: AppColors.ACCENT_COLOR_SECONDARY,
                    splashRadius: 18,
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.delete_forever,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ),
                flex: 2,
              )
            ],
          )),
    ));
  }
}
