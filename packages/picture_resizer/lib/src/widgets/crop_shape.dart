import "package:flutter/material.dart";
import "package:flutter/material.dart";
import "package:picture_resizer/src/models/crop_shape_option.dart";

class CropShapeWidget extends StatefulWidget {
  BoxShape shape;
  final List<CropShapeOption> cropShapesOptions;
  final Widget popMenuIcon;
  final String popMenuTooltip;

  CropShapeWidget({
    super.key,
    required this.shape,
    this.cropShapesOptions = const [],
    required this.popMenuIcon,
    required this.popMenuTooltip
  });

  @override
  State<CropShapeWidget> createState() => _CropShapeWidgetState();
}

class _CropShapeWidgetState extends State<CropShapeWidget> {

  List<PopupMenuEntry<BoxShape>> getPopupMenuItems() {
    return [
      ...widget.cropShapesOptions.map((option) => PopupMenuItem(
        value: option.shape,
        child: Text(option.title),
      ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<BoxShape>(
      icon: widget.popMenuIcon,
      itemBuilder: (context) => getPopupMenuItems(),
      tooltip: 'Crop Shape',
      onSelected: (x) {
        setState(() {
          widget.shape = x;
        });
      },
    );
  }
}
