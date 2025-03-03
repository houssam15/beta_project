import 'package:alpha_flutter_project/authentication/authentication.dart';
import 'package:alpha_flutter_project/login/login.dart';

class SocialMediaItem extends Equatable{
  IconData icon;
  String title;
  bool showText = false;
  bool isSelected = false;

  SocialMediaItem({
     required this.icon,
     required this.title
  });

  SocialMediaItem toggleShowText(){
    showText = !showText;
    return this;
  }

  SocialMediaItem changeIsSelected(bool? value){
    isSelected = value??false;
    return this;
  }

  static List<SocialMediaItem> fromRepository(){
    return [
      SocialMediaItem(icon: Icons.ice_skating_outlined, title: "Facebook account for somethings"),
      SocialMediaItem(icon: Icons.abc_outlined, title: "Facebook "),
      SocialMediaItem(icon: Icons.g_mobiledata_rounded, title: "Facebook  somethings"),
      SocialMediaItem(icon: Icons.baby_changing_station_outlined, title: "Facebook account for somethings,somethingssomet hingssomethings"),
      SocialMediaItem(icon: Icons.dangerous, title: "Facebook account for somethings"),
      SocialMediaItem(icon: Icons.baby_changing_station, title: "Facebook account for somethings"),
      SocialMediaItem(icon: Icons.face, title: "Facebook account for somethings"),
      SocialMediaItem(icon: Icons.abc_outlined, title: "Facebook account for somethings"),
      SocialMediaItem(icon: Icons.offline_bolt, title: "Facebook account for somethings"),
      SocialMediaItem(icon: Icons.padding, title: "Facebook account for somethings")
    ];
  }

  @override
  List<Object?> get props => [icon,title];

}