enum PageName {
  ProgressPage,
  EventPage,
  SettingPage,
}

extension PageNameExtend on PageName {

  int get Index {
    switch(this){
      case PageName.ProgressPage:
        return 0;
      case PageName.EventPage:
        return 1;
      case PageName.ProgressPage:
        return 2;
    }
  }
}