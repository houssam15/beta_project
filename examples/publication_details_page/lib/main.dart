import 'package:flutter/material.dart';
import 'package:publication_details_page/views/pages/publication_details.dart';
import "package:video_viewer/video_viewer.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  VideoViewer.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PublicationDetailsPage(),
    );
  }
}

