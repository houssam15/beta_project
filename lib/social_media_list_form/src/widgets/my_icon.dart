import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  MyIcon({super.key,this.onTap,required this.icon});
  void Function()? onTap;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding:EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Icon(icon,color: Theme.of(context).colorScheme.onError)
      ),
    );
  }
}
