part of 'models.dart';

class SocialMediaItem extends Equatable{
  String id;
  IconData icon;
  String title;
  SocialMediaErrorItem? error;
  String? uploadUrl;
  bool showText = false;
  bool isSelected = false;
  bool isLoading = false;
  bool isUploading = false;
  int? progress;
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

  static List<SocialMediaItem> fromState(SocialMediaListFormRemoteState state){
    List<SocialMediaItem> items = [];
    for(fur.UploadDocumentResponseWarning elm in state.uploadDocumentResponse?.getNetworks() ?? [] ){
      try{
        items.add(
            SocialMediaItem(
                id: elm.id.toString(),
                icon: elm.socialMediaItems.first.icon,
                title: elm.socialMediaItems.first.name.toString(),
                uploadUrl: state.uploadDocumentResponse?.getUploadUrl(state.mediaType),
                error: SocialMediaErrorItem.fromRepository(elm,state)
            )
        );
      }catch(err){
        print(err);
      }

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

  SocialMediaItem setUploading(bool uploading){
    isUploading = uploading;
    return this;
  }

  SocialMediaItem setProgress(int? progress){
    this.progress = progress;
    return this;
  }

  static Map<String,IconData> get faIconNameMapping => {
    "facebook":FontAwesomeIcons.facebook,
    "instagram":FontAwesomeIcons.instagram,
    "linkedin":FontAwesomeIcons.linkedin,
    "google":FontAwesomeIcons.google
  };

  String getUploadUrl(){
      return uploadUrl ?? "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D";
  }

  @override
  List<Object?> get props => [id,icon,title,error,showText,isLoading,isSelected,uploadUrl];

}