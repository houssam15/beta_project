import "package:flutter/material.dart";

class SocialMediaListPublicationsView extends StatefulWidget {
  const SocialMediaListPublicationsView({super.key});

  @override
  State<SocialMediaListPublicationsView> createState() => _SocialMediaListPublicationsViewState();
}

class _SocialMediaListPublicationsViewState extends State<SocialMediaListPublicationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Social media publications list"),
      ),
    );
  }
}
