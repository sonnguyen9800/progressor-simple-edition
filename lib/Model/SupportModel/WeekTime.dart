import 'dart:math';

enum WeekDay {
  MON,
  TUE,
  WED,
  THU,
  FRI,
  SAT,
  SUN
}

class WeekTime {
  WeekDay weekDay = WeekDay.MON;
  int hour = 0; //HOUR in 24 hour format
  int minute = 0; //Minute

  WeekTime(WeekDay weekDay, int hour, int minute){
    this.weekDay = weekDay;
    this.hour = hour;
    this.minute = minute;
  }
  WeekTime.sample(){
    this.weekDay = WeekDay.MON;
    this.hour = Random().nextInt(24);
    this.minute = Random().nextInt(60);
  }

  @override
  String toString() {
    var textHour = (hour == 0) ? "00" : hour.toString();
    var textMin = (minute == 0) ? "00" : minute.toString();
    var postConvention = (hour >= 12) ? "pm" : "am";
    return weekDay.toString().split('.').last.toUpperCase() + ":" + textHour + "h" + textMin + postConvention;
  }

  // Time stored take the form of: "MON_12_40" -> "Monday, 12h40am"
  String toStringSimple() {
    return weekDay.toString().split('.').last.toUpperCase() +
        "_" + hour.toString() + "_" + minute.toString();
  }
}