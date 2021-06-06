import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Component/Alert/WarnDeletePopup.dart';
import 'package:progressor/Component/Core/ProgressCard/ProgressItemControlView.dart';
import 'package:progressor/Component/Core/TimeReminderGrid.dart';
import 'package:progressor/LibModified/CustomizedExpansionTile.dart';
import 'package:progressor/Model/Progress.dart';
import 'package:progressor/Utils/Define.dart';

class ProgressCardView extends StatefulWidget {
  @required final Progress progress;
  final Function() notifyParent;
  ProgressCardView({ Key key, this.progress, this.notifyParent}) : super(key:  key);

  @override
  _ProgressCardViewState createState() => _ProgressCardViewState();
}

class _ProgressCardViewState extends State<ProgressCardView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(

          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1),
            borderRadius: BorderRadius.circular(0),
          ),
          margin: EdgeInsets.all(8),
          shadowColor: AppColors.ACCENT_COLOR_SECONDARY,
          elevation: 3,
          child: CustomizedExpansionTile(
            key: GlobalKey(),
            tilePadding: EdgeInsets.all(0),
            childrenPadding: EdgeInsets.all(10),
            //leading: ProgressItemNameView(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: ProgressItemNameView(name: widget.progress.name),
                  flex: 6,
                ),
                Flexible(
                  child: ProgressItemControllView(progress: widget.progress),
                  flex: 4,
                ),
              ],
            ),
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    print("Hi guys");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.SECONDARY_COLOR),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColors.PRIMARY_COLOR),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                            "Add Weekly Reminder",
                          style:  GoogleFonts.shareTech(
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: IconButton(
                          iconSize: 30,
                          color: AppColors.PRIMARY_COLOR,
                          onPressed: () {
                            _showDeleteAlertBox(context);
                          },
                          icon: Icon(Icons.cancel_outlined),
                        )
                      ),
                    ],
                  ),

                ),
              ),

              TimeReminderGrid(progress: widget.progress)
            ],
          )),

    );
  }

  Future _showDeleteAlertBox(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context){
        return WarnDeletePopup(
          content: AppTextConst.POPUP_TITLE_WANR_DELETE_PROGRESS,
          progress: widget.progress,
          notifyParent: _UpdatePageView,
        );
      },
    );
  }

  void _UpdatePageView() {
    widget.notifyParent();
    setState((){

    });
  }
}


class ProgressItemNameView extends StatefulWidget {

  @required final String name;
  const ProgressItemNameView ({ Key key, this.name }): super(key: key);

  @override
  _ProgressItemNameViewState createState() => _ProgressItemNameViewState();
}

class _ProgressItemNameViewState extends State<ProgressItemNameView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Text(
          widget.name ,
          style: GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}



