import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

class MyTitle extends StatelessWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
      child: Center(
        child: Text(context.tr("Publication details")),
      ),
    );
  }
}
