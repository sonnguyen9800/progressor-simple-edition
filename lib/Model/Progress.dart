import 'dart:math';

import 'package:progressor/Model/Database/ProgressTable.dart';
import 'package:progressor/Utils/UtilsMethod.dart';

import 'SupportModel/WeekTime.dart';

class Progress {


  int id;
  String name;
  int totalSecond;
  String lstWeekTime;


  //Static Values:
  static final int DEFAULT_TOTAL_SECOND = 7200;

  //Constructor
  Progress({
    this.id,
    this.totalSecond,
    this.name,
    this.lstWeekTime,
  });

  //Simple constructor
  Progress.fromName(String name){
    this.name = name;
    this.totalSecond = DEFAULT_TOTAL_SECOND;
    this.lstWeekTime = "";

  }

  // Full Constructor
  Progress.fulldetails(int id, String name, int totalSecond,  List<WeekTime> lstWeekTime){
    this.id = id;
    this.name = name;
    this.totalSecond = totalSecond;
    this.lstWeekTime = Utils.FromWeekTimeLstToString(lstWeekTime) ;
  }

  Progress.fulldetailsWeekTimeStr(int id, String name, int totalSecond, String lstWeekTime){
    this.id = id;
    this.name = name;
    this.totalSecond = totalSecond;
    this.lstWeekTime = lstWeekTime;
  }

  static List<Progress> produceDummyProgresses(){

    var emptyListProgress = [
      new Progress.fromName("Practice Piano: Linkedin Learning Course"),
      new Progress.fromName("Learn Dancing: Electro Swing"),
      new Progress.fromName("Learning C++: OpenGL and Game Dev"),
      new Progress.fromName("Writing Novel 4 Hour"),
      new Progress.fromName("Reading Novel & Book for 5 Hours")
    ];

    var simpleWeekTime = [
      new WeekTime.sample(),
      new WeekTime.sample(),
      new WeekTime.sample(),
      new WeekTime.sample()
    ];

    var simpleWeekTime2 = [
      new WeekTime.sample(),
      new WeekTime.sample(),
    ];

    emptyListProgress.first.lstWeekTime = Utils.FromWeekTimeLstToString(simpleWeekTime);
    emptyListProgress.last.lstWeekTime = Utils.FromWeekTimeLstToString(simpleWeekTime2);

    return emptyListProgress;
  }

    Map<String, Object> toJson() => {
      ProgressTableFields.id: id,
      ProgressTableFields.name: name,
      ProgressTableFields.totalSecond: totalSecond,
      ProgressTableFields.reminderLst: lstWeekTime,
   };


  static Progress fromJson(Map<String, Object> json) => Progress(
    id: json[ProgressTableFields.id] as int,
    totalSecond: json[ProgressTableFields.totalSecond] as int,
    name: json[ProgressTableFields.name] as String,
    lstWeekTime: json[ProgressTableFields.reminderLst] as String,
  );

  @override
  String toString() {
    // TODO: implement toString
    print("Name: ${this.name} TotalSecond ${this.totalSecond} LstReminder: '${this.lstWeekTime}'");
  }

}



