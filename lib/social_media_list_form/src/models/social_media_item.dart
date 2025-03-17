part of 'models.dart';

class SocialMediaItem extends Equatable{
  int id;
  IconData icon;
  String title;
  SocialMediaErrorItem? error;
  String? uploadUrl;
  bool showText = false;
  bool isSelected = false;
  bool isLoading = false;

  SocialMediaItem({
     required this.id,
     required this.icon,
     required this.title,
     this.error,
     this.uploadUrl
  });

  static IconData toFaIcon(String iconKey){
    return faIconNameMapping[iconKey.toLowerCase()] ?? FontAwesomeIcons.circle;
  }

  SocialMediaItem toggleShowText(){
    showText = !showText;
    return this;
  }

  SocialMediaItem changeIsSelected(bool? value){
    isSelected = value??false;
    return this;
  }


  static List<SocialMediaItem> fromRepository(dynamic data){
    List<SocialMediaItem> items = [];
    for(dynamic elm in data as List){
        items.add(
            SocialMediaItem(
                id: elm.id,
                icon: toFaIcon(elm.icon),
                title: elm.title,
                uploadUrl: elm.uploadUrl,
                error: SocialMediaErrorItem.fromRepository(elm.error)
            )
        );
    }
    return items;
  }

  bool hasError(){
    return error!=null && error?.isEditUploaded==false;
  }

  bool hasUrl(){
    return error==null && uploadUrl!=null;
  }

  SocialMediaItem setUploadUrl(String? url){
    if(error == null) return this;
    uploadUrl = url;
    error = null;
    return this;
  }

  SocialMediaItem setLoading(bool loading){
    isLoading = loading;
    return this;
  }

  static Map<String,IconData> get faIconNameMapping => {
    "facebook":FontAwesomeIcons.facebook,
    "instagram":FontAwesomeIcons.instagram,
    "linkedin":FontAwesomeIcons.linkedin,
    "google":FontAwesomeIcons.google
  };

  @override
  List<Object?> get props => [id,icon,title,error,showText,isLoading,isSelected,uploadUrl];

}