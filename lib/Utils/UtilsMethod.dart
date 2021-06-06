import 'package:progressor/Model/SupportModel/WeekTime.dart';

class Utils {
  static String FromSecondToTextTime(int second, {bool skipSecond = false}) {
    int hour = second ~/ 3600;
    int minute = (second - hour * 3600) ~/ 60;
    int secondLeft = second - hour * 3600 - minute * 60;
    return TimeToText(hour, minute, secondLeft, skipSecond: skipSecond);
  }

  static String TimeToText(int hour, int minute, int second, {bool skipSecond = false}) {

    var textHour = (hour == 0) ? "00" : hour.toString();
    var textMin = (minute == 0) ? "00" : minute.toString();
    if (minute < 10 && minute > 0){
      textMin = "0" + textMin;
    }
    var textSec = (second == 0) ? "00" : second.toString();
    if (second < 10 && second > 0){
      textSec = "0" + textSec;
    }

    if (skipSecond){
      if (hour == 0){
        return textMin + " minute";
      }
      return textHour + " hour and " + textMin + " minute";
    }
    return textHour + ":" + textMin + ":" + textSec;
  }

  static int FromMinuteToSecond(int minute){
    return minute*60;
  }

  static String FromMinuteToTextTime(int minute, {bool skipSecond = false}) {
    int hour = minute ~/ 60;
    int minuteLeft = minute - hour * 60;
    return TimeToText(hour, minuteLeft , 0, skipSecond: skipSecond);
  }

  static List<WeekTime> FromStringToWeekTimeLst(String input) {
    var array = input.split(";");
    WeekDay resWeekDay = WeekDay.MON;
    int hour = 0;
    int minute = 0;
    List<WeekTime> lstWeekTime = new List.empty(growable: true);

    array.forEach((element) {
      var SubArray = element.split("_");
      var concatenate = StringBuffer();
      SubArray.forEach((item){
        concatenate.write(item);
      });
      if (concatenate.length > 0){
        resWeekDay = cvtWeekDayFromString(SubArray[0]);
        hour = int.parse(SubArray[1]);
        minute = int.parse(SubArray[2]);
        var temp = new WeekTime(resWeekDay, hour, minute);
        print(temp.weekDay.toString() + " ; " + hour.toString() + " ; " + minute.toString());
        lstWeekTime.add(temp);
      }
    });
    return lstWeekTime;
  }

  static String FromWeekTimeLstToString(List<WeekTime> list) {
    String res = "";
    list.forEach((element) {
      res = res + element.toStringSimple() + ";";
    });
    return res;
  }

  static WeekDay cvtWeekDayFromString(String name) {
    switch (name) {
      case "SUN":
        return WeekDay.SUN;
        break;
      case "MON":
        return WeekDay.MON;
        break;
      case "TUE":
        return WeekDay.TUE;
        break;
      case "WED":
        return WeekDay.WED;
        break;
      case "THU":
        return WeekDay.THU;
        break;
      case "FRI":
        return WeekDay.FRI;
        break;
      case "SAT":
        return WeekDay.SAT;
        break;
      default:
        return WeekDay.MON;
    }
  }


}
