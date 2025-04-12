import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";

class LoadingPublications extends StatelessWidget {
  const LoadingPublications({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(color: Theme.of(context).progressIndicatorTheme.color ?? Colors.black, size: 30);

  }
}
