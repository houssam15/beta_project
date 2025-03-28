import 'package:social_media_api/social_media_api.dart';

import '../validation/validation.dart';
import 'constraint_properties.dart';

class Constrains extends ConstraintsValidation{
  ConstraintProperties? globalProperties;
  List<SocialMediaItemWithConstrains> socialMediaItemWithConstrains;
  List<String> errors;

  Constrains({
    this.globalProperties,
    this.socialMediaItemWithConstrains = const [],
    this.errors = const []
  });

  static Constrains fromJson(dynamic data) {
    Constrains constraints = Constrains();
    try{
      final cv = ConstraintsValidation();
      if(!cv.validate(data).isValid()){
        constraints.errors = cv.getErrors();
      }else if(data["error"] != null || data["errors"] != null){
        constraints.errors = data["errors"] != null ? data["errors"]:[data["error"]];
      }else{
        constraints.globalProperties = ConstraintProperties.fromJson(data["constraints"]);
        List<SocialMediaItemWithConstrains> items = [];
        for(dynamic elm in data["networks"]){
          items.add(SocialMediaItemWithConstrains.fromJson(elm));
        }
        constraints.socialMediaItemWithConstrains = items;
      }
    }catch(err){
      constraints.errors = [err.toString()];
    }
    return constraints;
  }

  bool isValid(){
    return errors.isEmpty;
  }



  @override
  List<Object?> get props => [globalProperties,socialMediaItemWithConstrains];
}