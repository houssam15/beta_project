import 'package:crop/crop.dart';
import 'package:flutter/material.dart';

class RotationSlider extends StatefulWidget {
  final CropController controller;
  double rotation;

  RotationSlider({super.key,required this.controller,required this.rotation});

  @override
  State<RotationSlider> createState() => _RotationSliderState();
}

class _RotationSliderState extends State<RotationSlider> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SliderTheme(
        data: Theme.of(context).sliderTheme,
        child: Slider(
          divisions: 360,
          value: widget.rotation,
          min: -180,
          max: 180,
          label: '${widget.rotation}°',
          onChanged: (n) {
            setState(() {
              widget.rotation = n.roundToDouble();
              widget.controller.rotation = widget.rotation;
            });
          },
        ),
      ),
    );
  }
}
