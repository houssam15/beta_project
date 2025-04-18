import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";


class QrcodeListEmpty extends StatelessWidget {
  const QrcodeListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/common/empty_box.png"),
          SizedBox(height: 20),
          Text(context.tr("No element found !"))
        ]
    );
  }
}
