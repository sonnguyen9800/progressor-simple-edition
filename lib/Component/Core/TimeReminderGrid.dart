import 'package:flutter/material.dart';
import 'package:progressor/Component/Core/TimeReminder/TimeReminderView.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Utils/UtilsMethod.dart';


class TimeReminderGrid extends StatefulWidget {
  @required final Progress progress;

  TimeReminderGrid({ Key key, this.progress}) : super(key:  key);

  @override
  _TimeReminderGridState createState() => _TimeReminderGridState();
}

class _TimeReminderGridState extends State<TimeReminderGrid> {

  @override
  Widget build(BuildContext context) {


    if (Utils.FromStringToWeekTimeLst(widget.progress.lstWeekTime).isEmpty){
      return Container();
    }
    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 3,
      children:  Utils.FromStringToWeekTimeLst(widget.progress.lstWeekTime).map((e) =>TimeReminderView(weekTime: e)).toList()
    );
  }
}
