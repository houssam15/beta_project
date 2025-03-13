import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class TextIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  const TextIcon({super.key,required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon,color: Colors.blue,),
            SizedBox(width: 5),
            Text(text,style: TextStyle(color: Colors.blue),)
          ],
        )
    );
  }
}
