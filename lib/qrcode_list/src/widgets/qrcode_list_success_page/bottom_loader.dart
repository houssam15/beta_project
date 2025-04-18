import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 15,
        width: 15,
        child: CircularProgressIndicator(strokeWidth: 1.5,color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}