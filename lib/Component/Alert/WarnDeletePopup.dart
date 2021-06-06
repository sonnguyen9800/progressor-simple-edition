import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Component/Snackbar/Success.dart';
import 'package:progressor/Model/Database/ProgressorDB.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Utils/Define.dart';

class WarnDeletePopup extends StatefulWidget {
  final Function() notifyParent;
  final String content;
  final Progress progress;
  WarnDeletePopup({Key key, this.notifyParent, this.progress, this.content}) : super(key: key);

  @override
  _WarnDeletePopupState createState() => _WarnDeletePopupState();
}

class _WarnDeletePopupState extends State<WarnDeletePopup> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      backgroundColor: AppColors.ACCENT_COLOR,
      title: Text(

        widget.content,
        style: GoogleFonts.patrickHand(
          fontWeight: FontWeight.bold,
          color: AppColors.PRIMARY_COLOR,
        ),
        textAlign: TextAlign.center,
      ),

      actions: <Widget>[
          TextButton(
          child: Text(
              "Accept",
            style: GoogleFonts.robotoMono(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            DeleteProgressItem();
            Navigator.pop(context);
          }),

          TextButton(
          child: Text(
              "Cancel",
            style: GoogleFonts.robotoMono(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          })
      ],
    );
  }

  Future DeleteProgressItem() async {
    var id = await ProgressorDB.instance.delete(widget.progress);
    if (id == null) {
      // Cannot Delete -> ST Wrong Happend
      ScaffoldMessenger.of(context).showSnackBar(
          CreateSnackBar(AppTextConst.SNACKBAR_DELETE_PROGRESS_FAILURE, SnackbarType.FAILURE)
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          CreateSnackBar(AppTextConst.SNACKBAR_DELETE_PROGRESS_SUCCESS, SnackbarType.SUCCESS)
      );
      widget.notifyParent();
    }
  }



}

