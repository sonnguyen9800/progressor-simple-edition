import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressor/Component/Core/ProgressCardView.dart';
import 'package:progressor/Model/Database/ProgressorDB.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Utils/Define.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({
    Key key,
  }) : super(key: key);
  @override
  ProgressPageState createState() => ProgressPageState();
}

class ProgressPageState extends State<ProgressPage> {
  List<Progress> LstProgress = List<Progress>.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshProgressLst();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SafeArea(
        child: ListView(
          children: this.LstProgress.map((e) => ProgressCardView(progress: e, notifyParent: refreshProgressLst)).toList()
        )

      ),
    );
  }

  Future refreshProgressLst() async {

    var newList = await ProgressorDB.instance.getAllProgress();

    setState(()  {
      this.LstProgress = newList;
    });

  }
}