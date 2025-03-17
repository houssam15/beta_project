import "package:flutter/material.dart";

class IconWithTitle extends StatelessWidget {
  void Function()? onTap;
  IconData icon;
  String title;
  IconWithTitle({super.key,this.onTap,required this.icon,required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Card(
          shadowColor: Colors.white.withOpacity(0.3),
          color: Colors.transparent,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Icon(icon,size: 30,color: Theme.of(context).colorScheme.tertiary),
                Text(title,style: Theme.of(context).textTheme.titleSmall)
              ],
            ),
          )
      ),
    );
  }
}
