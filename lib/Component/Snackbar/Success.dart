
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Utils/Define.dart';

SnackBar CreateSnackBar(String title, SnackbarType type){
  return SnackBar(

    backgroundColor: type == SnackbarType.SUCCESS ? AppColors.SUCCESS : AppColors.FAILURE,
    content: Text(
      title,
      style: GoogleFonts.boogaloo(
        color: AppColors.PRIMARY_COLOR,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        wordSpacing: 3,
      ),

      textAlign: TextAlign.center,
    ),
  );

}


enum SnackbarType {
  SUCCESS,
  FAILURE,
}
