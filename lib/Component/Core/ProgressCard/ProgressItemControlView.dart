import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:progressor/Component/Core/ProgressCard/FieldStatusIndicator.dart';
import 'package:progressor/Component/Core/ProgressCard/FieldTimeIndicator.dart';
import 'package:progressor/Model/Database/ProgressorDB.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Model/SupportModel/ProgressTracking.dart';
import 'package:progressor/Service/NotificationService.dart';
import 'package:progressor/Utils/Define.dart';


enum ProgressState {
  NOT_FINISH,
  FINISH,
  ON_GOING,
}

class ProgressItemControllView extends StatefulWidget {
  @required
  Progress progress;
  ProgressItemControllView({Key key, this.progress}) : super(key: key);

  @override
  _ProgressItemControllViewState createState() =>
      _ProgressItemControllViewState();
}

class _ProgressItemControllViewState extends State<ProgressItemControllView> with WidgetsBindingObserver {
  @required int _currentSecond = 0;
  ProgressState _state = ProgressState.NOT_FINISH;
  Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateCurrentSecond(widget.progress); // Update Current Second
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    _HandleEndCounter();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.SECONDARY_COLOR,
      alignment: Alignment.center,
      padding: EdgeInsets.all(0),
      child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          child: TextButton(
              onPressed: () {
                _HandlePress();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: FieldStatusIndicator(
                      progressState: _state,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: FieldTimeIndicator(
                      time: _currentSecond,
                      progress: widget.progress,
                    ),
                  )
                ],
              ))),
    );
  }

  Future<int> _updateCurrentSecond(Progress progress) async {
    int second = 0;
    await ProgressorDB.instance
        .GetThisWeekProgressTracking(progress.id)
        .then((value) => {
          if (value is ProgressTracking){
            second = value.second
          }else {
            second = 0
          }
      }
    );
    if (this.mounted){
      setState(() {
        _currentSecond = second;
      });
    }

    return second;

  }


  Future<bool> StartBackgroundRunning() async {
    bool enabled = FlutterBackground.isBackgroundExecutionEnabled;
    if (enabled == true) return false;
    bool success = await FlutterBackground.enableBackgroundExecution();
    return success;
  }
  Future<void> EndBackgroundRunning() async {
    bool enabled = FlutterBackground.isBackgroundExecutionEnabled;
    if (enabled == false) return;
    await FlutterBackground.disableBackgroundExecution();

  }


  void _HandlePress() {
    // Start Background Running

    var newState = _state;
    if (_state == ProgressState.NOT_FINISH || _state == ProgressState.FINISH) {
      newState = ProgressState.ON_GOING;
      _HandleStartCounter();

    }
    if (_state == ProgressState.ON_GOING) {
      if (_isComplete()) {
        newState = ProgressState.FINISH;
      } else {
        newState = ProgressState.NOT_FINISH;
      }
      _HandleEndCounter();
    }

    //Set State:
    setState(() {
      _state = newState;
    });
  }

  bool _isComplete() {
    if (_currentSecond >= widget.progress.totalSecond){
      return true;
    }
    return false;
  }

  void _HandleEndCounter()  {
    EndBackgroundRunning();
    if (_timer == null) return;
    _timer.cancel();
    ProgressorDB.instance.UpdateProgressTracking(widget.progress, _currentSecond);

  }

  Timer _HandleStartCounter()  {
    var backgroundRunning = StartBackgroundRunning();

    _displayNotificationBegin();
    _timer = Timer.periodic(
        Duration(seconds: 1),
            (timer){
      updateFieldItem();
    });
  }

  void updateFieldItem() {
    if (_state == ProgressState.FINISH || _state == ProgressState.NOT_FINISH) return;
    //("Second:" + _currentSecond.toString());
    _currentSecond++;
    if (_currentSecond == widget.progress.totalSecond){
      _displayNotificationFinishTrack();
    }
    if (_currentSecond % 10 == 0 && _currentSecond != 0){
      ProgressorDB.instance.UpdateProgressTracking(widget.progress, _currentSecond);
    }
    if (this.mounted){
      setState(() {

      });
    }

  }

  Future _displayNotificationFinishTrack() async {
    //print("Start Notification");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    //NotificationService().instantNofitication();
    await NotificationService().flutterLocalNotificationsPlugin
        .show(
        AppNotification.PROGRESS_FINISH_ID,
        AppNotification.PROGRESS_FINISH_TITLE,
        widget.progress.name + AppNotification.PROGRESS_FINISH_BODY_POSTFIX,
        platformChannelSpecifics,
        payload: 'test'
    );

  }

  Future _displayNotificationBegin() async {
    //print("Start Notification");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    //NotificationService().instantNofitication();
    await NotificationService().flutterLocalNotificationsPlugin
    .show(
        AppNotification.PROGRESS_BEGIN_ID,
        AppNotification.PROGRESS_BEGIN_TITLE,
        widget.progress.name + AppNotification.PROGRESS_BEGIN_BODY_POSTFIX,
        platformChannelSpecifics,
      payload: 'test'
    );

  }



}
