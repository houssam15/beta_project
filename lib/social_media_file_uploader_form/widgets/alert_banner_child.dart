import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";

class AlertBannerChild extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  const AlertBannerChild({super.key,this.color = Colors.red,this.textColor = Colors.white,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: color,
      ),
      child: Text(
              text,
              style: TextStyle(
                color: textColor
              )
      )
    );
  }
}
