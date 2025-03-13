class AspectRatioOption {
  final double value;
  final String title;

  AspectRatioOption(this.value, this.title);

  static List<AspectRatioOption> getTestingData() {
    return [
      AspectRatioOption(1000 / 667.0, "Original"),
      AspectRatioOption(16.0 / 9.0, "16:9"),
      AspectRatioOption(4.0 / 3.0, "4:3"),
      AspectRatioOption(1.0, "1:1"),
      AspectRatioOption(3.0 / 4.0, "3:4"),
      AspectRatioOption(9.0 / 16.0, "9:16"),
    ];
  }
}
