part of 'models.dart';

class ValidConstraints extends Equatable{
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;

  ValidConstraints({
    required this.minHeight,
    required this.maxHeight,
    required this.minWidth,
    required this.maxWidth
  });

  static ValidConstraints? fromRepository(dynamic data){
    try{
      return ValidConstraints(
          minHeight: data.minHeight,
          maxHeight: data.maxHeight,
          minWidth: data.minWidth,
          maxWidth: data.maxWidth
      );
    }catch(err){
      return null;
    }
  }

  social_media_list_form_repository.ValidConstraints toRepository(){
    return social_media_list_form_repository.ValidConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        minHeight: minHeight,
        minWidth: minWidth
    );
  }



  @override
  List<Object?> get props => [minWidth,minHeight,maxWidth,maxHeight];

}