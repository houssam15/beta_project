import 'package:equatable/equatable.dart';

import '../../social_media_api.dart';

class SocialMediaItemWithConstrains extends Equatable{
  final String id;
  final String name;
  final String engine;
  final ConstraintProperties constraintProperties;

  SocialMediaItemWithConstrains({
    required this.id,
    required this.name,
    required this.engine,
    required this.constraintProperties
  });

  static SocialMediaItemWithConstrains fromJson(dynamic data){
    return SocialMediaItemWithConstrains(
      id:data["id"].toString(),
      name: data["name"].toString(),
      engine: data["engine"].toString(),
      constraintProperties: ConstraintProperties.fromJson(data["properties"])
    );
  }

  @override
  List<Object?> get props => [id,name,engine,constraintProperties];

}