import 'package:progressor/Model/Database/ProgressTrackingTable.dart';

class ProgressTracking {
  int ProgressId;
  int year;
  int week;
  int second;

  //Constructor
  ProgressTracking({
    this.ProgressId,
    this.year,
    this.week,
    this.second,
  });

  Map<String, Object> toJson() => {
    ProgressTrackingTableFields.progressId: ProgressId,
    ProgressTrackingTableFields.year: year,
    ProgressTrackingTableFields.week: week,
    ProgressTrackingTableFields.second: second,
  };

  static ProgressTracking fromJson(Map<String, Object> json) => ProgressTracking(
    ProgressId: json[ProgressTrackingTableFields.progressId] as int,
    year: json[ProgressTrackingTableFields.year] as int,
    week: json[ProgressTrackingTableFields.week] as int,
    second: json[ProgressTrackingTableFields.second] as int,
  );

  @override
  String toString() {
    // TODO: implement toString
    return "ProgressID: " + this.ProgressId.toString()
        + " Year: " + this.year.toString()
        + " Week: " + this.week.toString()
        + " Second: " + this.second.toString();
  }

}