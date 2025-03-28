
import 'package:equatable/equatable.dart';

import 'constraint_properties_for_picture.dart';
import 'constraint_properties_for_video.dart';

class ConstraintProperties extends Equatable{
  final ConstraintPropertiesForPicture constraintPropertiesForPicture;
  final ConstraintPropertiesForVideo constraintPropertiesForVideo;

  ConstraintProperties({
    required this.constraintPropertiesForPicture,
    required this.constraintPropertiesForVideo
  });

  static ConstraintProperties fromJson(dynamic data){
    try{
      return ConstraintProperties(
        constraintPropertiesForPicture:ConstraintPropertiesForPicture.fromJson(data["picture"]),
        constraintPropertiesForVideo: ConstraintPropertiesForVideo.fromJson(data["video"])
      );
    }catch(err){
      rethrow;
    }
  }

  @override
  List<Object?> get props => [constraintPropertiesForPicture,constraintPropertiesForVideo];

}