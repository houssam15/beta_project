part of 'models.dart';

class ValidConstraintsByRatio extends Equatable{
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final String ratio;

  ValidConstraintsByRatio({
    required this.minHeight,
    required this.maxHeight,
    required this.minWidth,
    required this.maxWidth,
    required this.ratio
  });

  static ValidConstraintsByRatio? fromRepository(dynamic data){
    try{
      return ValidConstraintsByRatio(
          minHeight: data.minHeight,
          maxHeight: data.maxHeight,
          minWidth: data.minWidth,
          maxWidth: data.maxWidth,
          ratio:data.ratio
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
        minWidth: minWidth,
        ratio: ratio
    );
  }



  @override
  List<Object?> get props => [minWidth,minHeight,maxWidth,maxHeight,ratio];

}