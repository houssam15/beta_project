import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";

class LoadingItems extends StatelessWidget {
  const LoadingItems({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(color: Theme.of(context).progressIndicatorTheme.color ?? Colors.black, size: 30);

  }
}
