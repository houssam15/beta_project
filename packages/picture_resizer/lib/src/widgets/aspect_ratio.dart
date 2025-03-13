import "package:crop/crop.dart";
import "package:flutter/material.dart";
import "../models/models.dart";

class AspectRatioWidget extends StatefulWidget {
  final CropController controller;
  final List<AspectRatioOption> aspectRatioOptions;

  const AspectRatioWidget({super.key,required this.controller,this.aspectRatioOptions = const []});

  @override
  State<AspectRatioWidget> createState() => _AspectRatioWidgetState();
}

class _AspectRatioWidgetState extends State<AspectRatioWidget> {
  List<PopupMenuEntry<double>> getPopupMenuItems() {
    return [
      ...widget.aspectRatioOptions.map((option) => PopupMenuItem(
        value: option.value,
        child: Text(option.title),
      )),
      const PopupMenuDivider(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      icon: const Icon(Icons.aspect_ratio),
      itemBuilder: (context) => getPopupMenuItems(),
      tooltip: 'Aspect Ratio',
      onSelected: (x) {
        widget.controller.aspectRatio = x;
        setState(() {});
      },
    );
  }
}
