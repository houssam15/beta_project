import 'package:crop/crop.dart';
import 'package:flutter/material.dart';

class UndoButtonWidget extends StatefulWidget {
  final CropController controller;
  final Widget popMenuIcon;
  final String popMenuTooltip;
  double rotation;

  UndoButtonWidget({
    super.key,
    required this.controller,
    required this.popMenuIcon,
    required this.popMenuTooltip,
    required this.rotation
  });

  @override
  State<UndoButtonWidget> createState() => _UndoButtonWidgetState();
}

class _UndoButtonWidgetState extends State<UndoButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.popMenuIcon,
      tooltip: widget.popMenuTooltip,
      onPressed: () {
        widget.controller.rotation = 0;
        widget.controller.scale = 1;
        widget.controller.offset = Offset.zero;
        setState(() {
          widget.rotation = 0;
        });
      },
    );
  }
}
