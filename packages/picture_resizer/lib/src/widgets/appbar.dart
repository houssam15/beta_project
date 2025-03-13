import "package:flutter/material.dart";

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final dynamic cropImage;
  const AppBarWidget({super.key,required this.cropImage});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Crop demo"),
      actions: [
        IconButton(
          onPressed: cropImage,
          tooltip: 'Crop',
          icon: const Icon(Icons.crop),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

