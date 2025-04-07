import "package:flutter/material.dart";

class QrcodeListView extends StatefulWidget {
  const QrcodeListView({super.key});

  @override
  State<QrcodeListView> createState() => _QrcodeListViewState();
}

class _QrcodeListViewState extends State<QrcodeListView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("qr code list"),);
  }
}
