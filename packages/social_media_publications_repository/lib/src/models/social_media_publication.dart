class SocialMediaPublication {

  List<SocialMediaPublication> toList(List<dynamic> data){
    List<SocialMediaPublication> items = [];
    for(dynamic item in data){
      try{
        items.add(
          SocialMediaPublication(

          )
        );
      }catch(err){}
    }
    return items;
  }
}