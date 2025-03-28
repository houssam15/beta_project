import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";

class ActionButton extends StatelessWidget {
  ActionButton(this.state,{super.key,required this.onTap,required this.icon});
  FileUploaderState state;
  void Function()? onTap;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon,color: Colors.black,size: 20),
    );
  }
}
