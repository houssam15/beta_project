class SocialMediaListFormArguments{
  /// Show the HomeLayout AppBar , set to false to avoid have two AppBars in same page
  final String appBarTitle;

  SocialMediaListFormArguments({
    this.appBarTitle = "Social media list"
  });

  SocialMediaListFormArguments fromJson(dynamic args) {
    return SocialMediaListFormArguments(
        appBarTitle: args?.appbarTitle??this.appBarTitle
    );
  }
}