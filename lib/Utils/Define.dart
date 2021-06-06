import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Colors Class - Resource class for storing app level color constants
class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFF393e46);
  static const Color SECONDARY_COLOR = Color(0xFF00adb5);
  static const Color ACCENT_COLOR = Color(0xFFaad8d3);
  static const Color ACCENT_COLOR_SECONDARY = Color(0xFFeeeeee);
  static const Color FAILURE = Color(0xFFe57373);
  static const Color SUCCESS = Color(0xFF81c784);

}

class AppTextConst {
  static const String APP_HEADER_NAME = "The Progressor";

  //Tab View Controller
  static const String TAB_VIEW_PROGRESS = "PROGRESS";
  static const String TAB_VIEW_EVENT = "EVENT";
  static const String TAB_VIEW_SETTING = "SETTING";

  //Tool tips on long press (Bottom Nav Bar Item)
  static const String TAB_VIEW_PROGRESS_TIP = "Monitor this week's progress";
  static const String TAB_VIEW_EVENT_TIP = "Make plan for future event";
  static const String TAB_VIEW_SETTING_TIP = "Make changes in app setting";
  static const String FAB_ADD_TIP = "Add a new Progress/Event Item";


  //Popups
  static const String POPUP_TITLE_CREATE_NEW_PROGRESS = "Create new Progress";

  static const String POPUP_TITLE_WANR_DELETE_PROGRESS = "Do you want to delete this item?";

  //SNACK BAR
  static const String SNACKBAR_CREATE_PROGRESS_SUCCESS = "New Progress Item Had been Created";
  static const String SNACKBAR_CREATE_PROGRESS_FAILURE = "Error Happend";

  static const String SNACKBAR_DELETE_PROGRESS_SUCCESS = "A Progress Item Had been Deleted";
  static const String SNACKBAR_DELETE_PROGRESS_FAILURE = "Cannot Delete";


}

class AppBackgroundTask {
  static const int PROGRESS_START_COUNTER_ALARMID = 100;

}

class AppDimension {
  static const double MEDIUM_SIZE = 30.0;
  static const double SMALL_SIZE = 15.0;

}
class AppFontFamily {
}

class AppNotification {

  static const PROGRESS_FINISH_ID = 1;
  static const PROGRESS_FINISH_BODY_POSTFIX = " has been finished this week";
  static const PROGRESS_FINISH_TITLE = " has been finished this week";

  static const PROGRESS_BEGIN_ID = 2;
  static const PROGRESS_BEGIN_BODY_POSTFIX = " has been started";
  static const PROGRESS_BEGIN_TITLE = "NEW Progress started";




}