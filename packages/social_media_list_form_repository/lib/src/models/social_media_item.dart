import "models.dart";

class SocialMediaItem {
  final int id;
  final String icon;
  final String title;
  final String? uploadUrl;
  final SocialMediaItemError? error;

  SocialMediaItem({
    required this.id,
    required this.icon,
    required this.title,
    this.uploadUrl,
    this.error
  });

  static List<SocialMediaItem> fromList(dynamic data) {
    List<SocialMediaItem> items = [];
    for (dynamic elm in data as List) {
      SocialMediaItem? item = fromJson(elm);
      if (elm != null) items.add(item!);
    }
    return items;
  }

  static SocialMediaItem? fromJson(dynamic data) {
    try {
      return SocialMediaItem(
        id:data.id,
        title: data.title,
        icon: data.icon,
        uploadUrl: data.uploadUrl,
        error: SocialMediaItemError.fromJson(data.error)
      );
    } catch (err) {
      return null;
    }
  }
}
