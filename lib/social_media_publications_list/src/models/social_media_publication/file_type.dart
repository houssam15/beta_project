import "package:alpha_flutter_project/login/login.dart";
import "package:social_media_publications_repository/social_media_publications_repository.dart" as smpr;
class FileType{
  smpr.SocialMediaPublicationDocumentFileType type;
  IconData icon;
  Color iconColor;

  FileType({
    required this.type,
    required this.icon,
    required this.iconColor
  });
}