import "package:flutter/material.dart";
import "../../home/home_app.dart";
import "../bloc/file_uploader.bloc.dart";

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FileUploaderState fileUploaderState;
  const MyAppBar(this.fileUploaderState,{super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
          onTap: ()=>Navigator.of(context).pushNamed(HomeApp.route),
          child: Icon(Icons.arrow_back)
      ),
      title: Text(
        "Create publication",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
