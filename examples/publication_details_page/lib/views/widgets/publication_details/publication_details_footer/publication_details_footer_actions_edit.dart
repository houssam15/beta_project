part of "publication_details_footer.dart";

class PublicationDetailsFooterActionsEdit extends StatelessWidget {
  const PublicationDetailsFooterActionsEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.black87,
      //minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

    return Container(
      margin: EdgeInsets.all(2),
      child: ElevatedButton(
          style: elevatedButtonStyle,
          child: Text("Edit"),
          onPressed: (){

          },
      ),
    );
  }
}
