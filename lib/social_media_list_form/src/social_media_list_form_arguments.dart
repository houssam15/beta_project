class SocialMediaListFormArguments{
  /// Show the HomeLayout AppBar , set to false to avoid have two AppBars in same page
  final String appBarTitle;
  final String? fileId;

  SocialMediaListFormArguments({
    this.appBarTitle = "Social media list",
    this.fileId = "1"
  });

  SocialMediaListFormArguments fromJson(dynamic args) {
    return SocialMediaListFormArguments(
        appBarTitle: args?.appbarTitle??this.appBarTitle,
        fileId: args?.fileId??this.fileId,
    );
  }
}