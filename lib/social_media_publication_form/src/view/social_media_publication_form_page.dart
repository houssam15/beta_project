import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "../../../home/home_app.dart";
import "../widgets/widgets.dart";
import "../models/models.dart";
class SocialMediaPublicationFormPage extends StatefulWidget {
  const SocialMediaPublicationFormPage({super.key});

  @override
  State<SocialMediaPublicationFormPage> createState() => _SocialMediaPublicationFormPageState();
}

class _SocialMediaPublicationFormPageState extends State<SocialMediaPublicationFormPage> {
  Config get _config => Config();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Container(
            width: double.infinity,
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MyTitle(),
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
                                ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),width: 2)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),width: 2)
                              ),
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
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),width: 2)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),width: 2)
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(_config.prevPageAppRoute!=null)
                                ElevatedButton(
                                  child: Text(
                                      "Back",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color:Theme.of(context).colorScheme.onError
                                      )
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).pushNamed(_config.prevPageAppRoute!);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                              (Set<WidgetState> states){
                                            if (states.contains(WidgetState.disabled)) {
                                              return Colors.grey; // Disabled state
                                            }
                                            return Theme.of(context).colorScheme.tertiary;                                          }
                                      )
                                  ),
                                ),
                                if(_config.nextPageAppRoute!=null)
                                ...[
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    child: Text(
                                        "Next",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color:Theme.of(context).colorScheme.onError
                                        )
                                    ),
                                    onPressed: (){
                                      Navigator.of(context).pushNamed(_config.nextPageAppRoute!);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                                (Set<WidgetState> states){
                                              if (states.contains(WidgetState.disabled)) {
                                                return Colors.grey; // Disabled state
                                              }
                                              return Theme.of(context).colorScheme.tertiary; // Enabled state
                                            }
                                        )
                                    ),
                                  ),
                                ]
                              ],
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



