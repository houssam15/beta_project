part of "publication_details_body.dart";

class PublicationDetailsBodyDescription extends StatelessWidget {
  const PublicationDetailsBodyDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Description :",
               style: TextStyle(
                    fontWeight: FontWeight.w600
               ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
                 """In Flutter, the Expanded widget requires its parent to provide bounded constraints. However, SingleChildScrollView offers unbounded height to its children, causing a conflict when Expanded tries to fill the available space. This results in the layout error you're seeing. Solution
                  To resolve this, you can wrap your SingleChildScrollView with a LayoutBuilder and use a ConstrainedBox to impose a minimum height constraint. This setup ensures that the Column inside the scroll view has bounded constraints, allowing Expanded to function correctly.
                  To resolve this, you can wrap your SingleChildScrollView with a LayoutBuilder and use a ConstrainedBox to impose a minimum height constraint. This setup ensures that the Column inside the scroll view has bounded constraints, allowing Expanded to function correctly.
                  To resolve this, you can wrap your SingleChildScrollView with a LayoutBuilder and use a ConstrainedBox to impose a minimum height constraint. This setup ensures that the Column inside the scroll view has bounded constraints, allowing Expanded to function correctly.
                  To resolve this, you can wrap your SingleChildScrollView with a LayoutBuilder and use a ConstrainedBox to impose a minimum height constraint. This setup ensures that the Column inside the scroll view has bounded constraints, allowing Expanded to function correctly.
               """,
            ),
          )
        ],
      ),
    );
  }
}
