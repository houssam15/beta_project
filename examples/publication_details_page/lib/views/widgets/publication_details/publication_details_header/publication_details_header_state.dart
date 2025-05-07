part of "publication_details_header.dart";
class PublicationDetailsHeaderState extends StatelessWidget {
  const PublicationDetailsHeaderState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
          "Published".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12
          ),
      )
    );
  }
}
