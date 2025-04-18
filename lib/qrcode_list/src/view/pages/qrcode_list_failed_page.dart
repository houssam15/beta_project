import "package:flutter/material.dart";
import "../../widgets/widgets.dart";

class QrcodeListFailedPage extends StatelessWidget {
  const QrcodeListFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FailedToGetData(),
    );
  }
}
