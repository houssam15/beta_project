class SocialMediaPublicationFormArguments{
    /// Show the HomeLayout AppBar , set to false to avoid have two AppBars in same page
    final String appBarTitle;

    SocialMediaPublicationFormArguments({
      this.appBarTitle = "Publication"
    });

    SocialMediaPublicationFormArguments fromJson(dynamic args) {
        return SocialMediaPublicationFormArguments(
          appBarTitle: args?.appbarTitle??this.appBarTitle
        );
    }
}