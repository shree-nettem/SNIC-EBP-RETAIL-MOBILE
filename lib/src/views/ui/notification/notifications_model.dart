class TotalNotifications {
  TotalNotifications({
    this.id,
    this.content,
    this.title,
    this.expirationDate,
    this.readAt,
    this.sentAt,
    this.link,
  });

  int id;
  String content;
  String title;
  DateTime expirationDate;
  DateTime readAt;
  DateTime sentAt;
  String link;

  factory TotalNotifications.fromJson(Map<String, dynamic> json) =>
      TotalNotifications(
        id: json["ID"] == null ? null : json["ID"],
        content: json["Content"] == null ? null : json["Content"],
        title: json["Title"] == null ? null : json["Title"],
        expirationDate: json["ExpirationDate"] == null
            ? null
            : DateTime.parse(json["ExpirationDate"]),
        readAt: json["ReadAt"] == null ? null : DateTime.parse(json["ReadAt"]),
        sentAt: json["SentAt"] == null ? null : DateTime.parse(json["SentAt"]),
        link: json["Link"] == null ? null : json["Link"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "Content": content == null ? null : content,
        "Title": title == null ? null : title,
        "ExpirationDate":
            expirationDate == null ? null : expirationDate.toIso8601String(),
        "ReadAt": readAt == null ? null : readAt.toIso8601String(),
        "SentAt": sentAt == null ? null : sentAt.toIso8601String(),
        "Link": link == null ? null : link,
      };
}
