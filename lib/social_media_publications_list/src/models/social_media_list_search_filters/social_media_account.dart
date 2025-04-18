import "dart:ui";

import "package:alpha_flutter_project/login/login.dart";
import "package:alpha_flutter_project/social_media_publications_list/src/models/models.dart";
import "package:social_media_publications_repository/social_media_publications_repository.dart" as smpr;
class SocialMediaAccount {
  String id;
  String title;
  IconData engineIcon;
  Color engineColor;
  bool isSelected;

  SocialMediaAccount({
    required this.id,
    required this.title,
    required this.engineIcon,
    required this.engineColor,
    this.isSelected = false
  });
  
  static List<SocialMediaAccount> toList(List<smpr.SocialMediaPublicationNetworkDocumentAccount> data){
    List<SocialMediaAccount> items = [];
    for(smpr.SocialMediaPublicationNetworkDocumentAccount item in data){
      SocialMediaAccount? doc = SocialMediaAccount.fromRepository(item);
      if(doc != null) items.add(doc);
    }
    return items;
  }
  
  static SocialMediaAccount? fromRepository(smpr.SocialMediaPublicationNetworkDocumentAccount data){
    try{
      return SocialMediaAccount(
          id: data.id,
          title: data.name,
          engineIcon: data.engine.getIcon(),
          engineColor: data.engine.getColor()
      );
    }catch(err){
      return null;
    }
  }

  SocialMediaAccount toggleIsSelected(){
    isSelected = !isSelected;
    return this;
  }

}