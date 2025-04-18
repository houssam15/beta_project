import "../../widgets/qrcode_list_initial_page/loading_items.dart";
import "package:flutter/material.dart";

class QrcodeListInitialPage extends StatelessWidget {
  const QrcodeListInitialPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingItems(),
    );
  }
}
