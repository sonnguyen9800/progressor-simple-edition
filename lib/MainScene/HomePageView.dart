import 'dart:ui';

/// Flutter code sample for PageView

// Here is an example of [PageView]. It creates a centered [Text] in each of the three pages
// which scroll horizontally.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Component/Alert/NewProgressPopup.dart';
import 'package:progressor/Component/Header.dart';
import 'package:progressor/MainScene/Pages/EventPage.dart';
import 'package:progressor/MainScene/Pages/ProgressPage.dart';
import 'package:progressor/MainScene/Pages/SettingPage.dart';
import 'package:progressor/Model/Database/ProgressorDB.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Model/UISupportModel/PageEnum.dart';
import 'package:progressor/Utils/Define.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => new _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  //Page Controller
  int _page = 0;
  PageController _c;
  //Current Opening Page:
  PageName _currentPage = PageName.ProgressPage;

  // State Loading
  bool _isLoadingSomeThing = false;

  List<Progress> LstProgress = new List.empty(growable: true);

  //Global Key
  GlobalKey<ProgressPageState> _keyProgressPage = GlobalKey();

  @override
  void initState(){
    _c =  new PageController(
      initialPage: _page,
    );
    super.initState();

    //refreshProgressLst();
  }





  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: Header(
        title: AppTextConst.APP_HEADER_NAME,
        appBar: AppBar(),
      ),

      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: AppColors.ACCENT_COLOR,
        currentIndex: _page,
        unselectedItemColor: AppColors.PRIMARY_COLOR,
        selectedItemColor: AppColors.SECONDARY_COLOR,
        unselectedLabelStyle: GoogleFonts.caveatBrush(
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
        ),
        selectedLabelStyle: GoogleFonts.caveatBrush(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
        ),
        onTap: (index){
          this._c.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
          changeTab(index);
          },

        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              tooltip: AppTextConst.TAB_VIEW_PROGRESS_TIP,
              icon: new Icon(Icons.alarm),
              label: AppTextConst.TAB_VIEW_PROGRESS),
          new BottomNavigationBarItem(
              tooltip: AppTextConst.TAB_VIEW_EVENT_TIP,
              icon: new Icon(Icons.event),
              label: AppTextConst.TAB_VIEW_EVENT),
          new BottomNavigationBarItem(
              tooltip: AppTextConst.TAB_VIEW_SETTING_TIP,
              icon: new Icon(Icons.settings),
              label: AppTextConst.TAB_VIEW_SETTING),
        ],
      ),

      body: new PageView(
        controller: _c,
        onPageChanged: (newPage){
          setState((){
            this._page=newPage;
          });
        },
        children: <Widget>[
          new ProgressPage(
            key: _keyProgressPage,
          ),
          new EventPage(),
          new SettingPage(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreateNewItem(_currentPage);
        },
        child: Icon(
            Icons.add,
            color: AppColors.PRIMARY_COLOR,
        ),
        backgroundColor: AppColors.ACCENT_COLOR,

      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void onTabPressed(int index){
    setState(() {
      _page = index;
    });
  }

  void changeTab(int index) {
    if (index == 0){
      _currentPage = PageName.ProgressPage;
    } else if (index == 1){
      _currentPage = PageName.EventPage;
    } else if (index == 2){
      _currentPage = PageName.SettingPage;
    }
  }

  void CreateNewItem(PageName page) {
    print(page.toString());

    if (page == PageName.ProgressPage){
      _asyncNewProgress(context);
    }
  }

  Future _asyncNewProgress(BuildContext context) async {

    return await showDialog(
        context: context,
        builder: (BuildContext context){

          return NewProgressPopup(
            notifyParent: UpdateProgressView,
          );
        },
    );
  }

  void UpdateProgressView(){
    _keyProgressPage.currentState.refreshProgressLst();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ProgressorDB.instance.close();
    super.dispose();
  }


}
