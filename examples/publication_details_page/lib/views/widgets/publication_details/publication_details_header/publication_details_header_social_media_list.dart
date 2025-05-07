part of "publication_details_header.dart";

class PublicationDetailsHeaderSocialMediaList extends StatelessWidget {
  PublicationDetailsHeaderSocialMediaList({super.key});

  final List icons = [
    {
      "icon":FontAwesomeIcons.facebook,
      "color":Colors.blue
    },
    {
      "icon":FontAwesomeIcons.instagram,
      "color":Colors.pink
    },
    {
      "icon":FontAwesomeIcons.linkedin,
      "color":Colors.blueAccent
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: Colors.white,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
        child: Row(
          children: [
            for(int i=0;i<icons.length;i++)
            Container(
                margin: EdgeInsets.only(right: 5),
                child: Icon(icons[i]["icon"],color: icons[i]["color"])
            )
          ],
        ),
      ),
    );
  }
}
