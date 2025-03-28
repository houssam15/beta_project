import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

import "../../../home/home_app.dart";

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      /*leading: InkWell(
          onTap: ()=>Navigator.of(context).pushNamed(HomeApp.route),
          child: Icon(Icons.arrow_back)
      ),*/
      title: Text(
        context.tr("Create publication"),
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
