import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "../widgets/widgets.dart";
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class SocialMediaPublicationFormPage extends StatefulWidget {
  const SocialMediaPublicationFormPage({super.key});

  @override
  State<SocialMediaPublicationFormPage> createState() => _SocialMediaPublicationFormPageState();
}

class _SocialMediaPublicationFormPageState extends State<SocialMediaPublicationFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 300,
            height: 500,
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                            child: Center(
                              child: Text("Publication details"),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TextField(
                            maxLines: null, // Allows unlimited lines
                            keyboardType: TextInputType.multiline, // Enables multiline input
                            style: TextStyle(
                                fontSize: 10
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(), // Adds a border
                                hintText: "Enter title here ...",
                                hintStyle: TextStyle(
                                    fontSize: 10
                                ),
                                labelText: "title",
                                labelStyle: TextStyle(
                                  fontSize: 12
                                )
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextField(
                              maxLines: null, // Allows unlimited lines
                              minLines: 3,
                              keyboardType: TextInputType.multiline, // Enables multiline input
                              style: TextStyle(
                                fontSize: 10
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(), // Adds a border
                                hintText: "Enter description here ...",
                                hintStyle: TextStyle(
                                    fontSize: 10
                                ),
                                labelText: "description",
                                labelStyle: TextStyle(
                                    fontSize: 12
                                ),
                              ),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Publish now",
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                              ),
                              Transform.scale(
                                scale: 0.6,
                                child: CupertinoSwitch(
                                  value: false,
                                  onChanged: (value) {
                                    // Handle state change
                                  },
                                  activeTrackColor: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            ],
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "select publish date",
                              style: TextStyle(
                                fontSize: 12
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                              child: CalendarDatePickerWidget()
                          ),
                        )
                      ]
                    ),
                  ),
              ),
            ),
        ),
      ),
    );
  }
}



