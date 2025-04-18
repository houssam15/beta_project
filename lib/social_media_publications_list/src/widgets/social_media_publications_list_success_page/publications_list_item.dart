import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";

import "../../models/social_media_publication/social_media_publication.dart";

class PublicationsListItem extends StatelessWidget {
  PublicationsListItem({super.key,required this.publication,required this.index});
  SocialMediaPublication publication;
  int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Color(0XFFF3E9E9),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(publication.document.fileType.icon,size: 15,),
                      SizedBox(width: 5,),
                      Text(publication.id ,style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(publication.createdAt.formattedDate,style: TextStyle(color: publication.createdAt.dateColor)),
                ),
              ),

              //Publication state
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: publication.state.backgroundColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 7),
                      child: Text(
                        publication.state.value.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize:12
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //Accounts
              Align(
                alignment: Alignment.bottomLeft,
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                  child: Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 30),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: publication.documents.length,
                      itemBuilder: (context, index) => Container(
                        child: Stack(
                          clipBehavior: Clip.none, // ← Important: Allows children to overflow
                          children: [
                            // Icon (centered)
                            Center(
                              child: Icon(
                                publication.documents[index].account!.icon,
                                color: publication.documents[index].account!.color,
                                size: 24, // Explicit size helps
                              ),
                            ),
                            // Circle indicator (positioned top-right)
                            Positioned(
                              top: -2, // ← Adjust these values as needed
                              right: -4,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: publication.documents[index].account!.engineState.color,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all( // Optional: Add border for better visibility
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                            if(publication.documents[index].account!.hasDuplicate(publication.documents) && publication.documents[index].account?.twoWordIndicator!=null)
                            Positioned(
                              top: -8, // ← Adjust these values as needed
                              left: -12,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all( // Optional: Add border for better visibility
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(
                                        publication.documents[index].account!.twoWordIndicator!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:10,
                                          fontWeight: FontWeight.w900
                                        ),
                                    ),
                                  ),
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                    ),
                  )
                ),
              ),

              //Title & description
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 40,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          publication.title.fullValue,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          )
                      ),
                      Text(
                          publication.description.fullValue,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15
                          )
                      ),
                    ],
                  ),
                ),
              )

            ]
        ),
      ),
    );
  }
}
