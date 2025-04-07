class SocialMediaPublication{
  String? _id;
  String? _title;
  String? _description;

  SocialMediaPublication setId(String? id){
    _id = id;
    return this;
  }

  SocialMediaPublication setTitle(String? title){
    _title = title;
    return this;
  }

  SocialMediaPublication setDescription(String? description){
    _description = description;
    return this;
  }

  String? getId(){
    return _id;
  }

  String? getTitle(){
    return _title;
  }

  String? getDescription(){
    return _description;
  }

}