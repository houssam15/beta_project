import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'dart:ui' as ui;
import "package:image_viewer/image_viewer.dart" as image_viewer;
import "../widgets/widgets.dart";
class CropImageResult extends StatefulWidget {
  final ui.Image? image;
  final String? extension;
  final double? width;
  final double? height;
  const CropImageResult({
    super.key,
    required this.image,
    required this.extension,
    required this.width,
    required this.height
  });

  @override
  State<CropImageResult> createState() => _CropImageResultState();
}

class _CropImageResultState extends State<CropImageResult> {

  late image_viewer.ImageProvider imageProvider;

  @override
  void initState() {
    imageProvider = image_viewer.ImageProvider();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(color: Colors.transparent), // Adds border to the table
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    TextIcon(icon: FontAwesomeIcons.arrowsUpDown,text: "${widget.height} px"),
                    TextIcon(icon: FontAwesomeIcons.arrowsLeftRight,text: "${widget.width} px"),
                    TextIcon(icon: FontAwesomeIcons.fileImage,text: "${widget.extension}")
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              /*child: RawImage(
                image: widget.image
              ),*/
              child: FutureBuilder(
                  future: imageProvider.setExtension(widget.extension).fromUiImage(widget.image),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: const CircularProgressIndicator());
                    }else if(snapshot.hasError || snapshot.data?.validateResult() == null){
                      return Text("Can't show picture");
                    }else{
                      return image_viewer.ImageViewer(
                          imageProvider: snapshot.data!
                      );
                    }
                  },
              )
            ),
          ),
        ],
      ),
    );
  }
}
