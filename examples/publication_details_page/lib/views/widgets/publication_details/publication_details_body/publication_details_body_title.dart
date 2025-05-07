part of "publication_details_body.dart";

class PublicationDetailsBodyTitle extends StatelessWidget {
  const PublicationDetailsBodyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Title :",
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("""This approach ensures that only one child widget is rendered based on the specified conditions. Using SizedBox.shrink() provides an empty widget when no conditions are met, avoiding potential layout issues."""),
          )
        ],
      ),
    );
  }
}
