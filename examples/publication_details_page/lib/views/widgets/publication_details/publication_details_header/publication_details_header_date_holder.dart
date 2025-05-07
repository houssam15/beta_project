part of "publication_details_header.dart";

class PublicationDetailsHeaderDateHolder extends StatelessWidget {
  PublicationDetailsHeaderDateHolder({
    super.key,
    required this.textAlign,
    required this.date
  });
  TextAlign textAlign;
  String date;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
        //color: Colors.yellow,
        child: Text(
            date,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 10
            ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
