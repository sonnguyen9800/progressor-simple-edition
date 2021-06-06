import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progressor/Utils/Define.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final Color _backgroundColor = AppColors.SECONDARY_COLOR;
  final String title;
  final AppBar appBar;
  /// you can add more fields that meet your needs

  const Header({Key key, this.title, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
          title.toUpperCase(),
        style: GoogleFonts.boogaloo(
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        )
      ),
      backgroundColor: _backgroundColor,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
