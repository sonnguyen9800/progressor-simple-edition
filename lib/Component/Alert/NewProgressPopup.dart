import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:progressor/Component/Snackbar/Success.dart';
import 'package:progressor/LibModified/CustomizedNumberPicker.dart';
import 'package:progressor/Model/Database/ProgressorDB.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Utils/Define.dart';
import 'package:progressor/Utils/UtilsMethod.dart';

class NewProgressPopup extends StatefulWidget {
  final Function() notifyParent;

  NewProgressPopup({Key key, this.notifyParent}) : super(key: key);

  @override
  _NewProgressPopupState createState() => _NewProgressPopupState();
}

class _NewProgressPopupState extends State<NewProgressPopup> {
  String _progressName;
  int _currentValue = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      title: Text(
        AppTextConst.POPUP_TITLE_CREATE_NEW_PROGRESS,
        style: GoogleFonts.boogaloo(
          fontWeight: FontWeight.bold,
          color: AppColors.PRIMARY_COLOR,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.ACCENT_COLOR,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          new TextField(
            autocorrect: false,

            maxLines: 1,
            style: GoogleFonts.patrickHand(
              decoration: TextDecoration.none,
            ),
            decoration: new InputDecoration(
                labelText: 'Name',
                hintText: 'e.g. Reading Book',
                alignLabelWithHint: true,
                labelStyle: GoogleFonts.boogaloo(
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: GoogleFonts.patrickHand()),
            onChanged: (value) {
              _progressName = value;
            },
          ),
          CustomizedNumberPicker.horizontal(
            numberToDisplay: 5,
            initialValue: _currentValue,
            minValue: 5,
            maxValue: 10080,
            step: 5,
            onChanged: (value) => setState(() => _currentValue = value),
            textStyle: GoogleFonts.orbitron(
              letterSpacing: 1,
              fontSize: 10,
            ),
            selectedTextStyle: GoogleFonts.orbitron(
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: AppColors.SECONDARY_COLOR,
              fontSize: 15,
            ),
          ),
          Text(
            'Time Set: ${Utils.FromMinuteToTextTime(_currentValue, skipSecond: true)}',
            style: GoogleFonts.boogaloo(
              fontWeight: FontWeight.bold,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            print("Current Name" + _progressName);
            CreateNewProgress();
          },
          child: Text(
            "Accept",
            style: GoogleFonts.robotoMono(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  // Create new Progress:

  Future CreateNewProgress() async {
    Progress newProgress = Progress(
      totalSecond: Utils.FromMinuteToSecond(_currentValue),
      name: _progressName,
      lstWeekTime: "",
    );
    var id = await ProgressorDB.instance.create(newProgress);

    if (id != null) {

      //Success
      widget.notifyParent();
      ScaffoldMessenger.of(context).showSnackBar(
          CreateSnackBar(AppTextConst.SNACKBAR_CREATE_PROGRESS_SUCCESS, SnackbarType.SUCCESS)
      );
    } else {
      //Failure
      ScaffoldMessenger.of(context).showSnackBar(
          CreateSnackBar(AppTextConst.SNACKBAR_CREATE_PROGRESS_FAILURE, SnackbarType.FAILURE)
      );
    }


    Navigator.pop(context);
  }
}
