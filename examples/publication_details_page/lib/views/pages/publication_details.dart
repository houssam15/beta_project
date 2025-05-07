import "package:flutter/material.dart";
import "../widgets/widgets.dart";
class PublicationDetailsPage extends StatefulWidget {
  const PublicationDetailsPage({super.key});

  @override
  State<PublicationDetailsPage> createState() => _PublicationDetailsPageState();
}

class _PublicationDetailsPageState extends State<PublicationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PublicationDetailsHeader(),
            PublicationDetailsBody(),
            PublicationDetailsFooter()
          ],
        ),
      ),
    );
  }
}
