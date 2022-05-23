class FeedbackValue {
  FeedbackValue({
    this.feedbackValue,
    this.feedbackCaption,
    this.date,
    this.product,
  });

  int feedbackValue;
  String feedbackCaption;
  DateTime date;
  String product;

  factory FeedbackValue.fromJson(Map<String, dynamic> json) => FeedbackValue(
        feedbackValue:
            json["feedbackValue"] == null ? null : json["feedbackValue"],
        feedbackCaption:
            json["feedbackCaption"] == null ? null : json["feedbackCaption"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
        product: json["Product"] == null ? null : json["Product"],
      );

  Map<String, dynamic> toJson() => {
        "feedbackValue": feedbackValue == null ? null : feedbackValue,
        "feedbackCaption": feedbackCaption == null ? null : feedbackCaption,
        "Date": date == null ? null : date.toString(),
        "Product": product == null ? null : product,
      };
}
