class MessageType {
  MessageType({
    this.label,
    this.value,
  });

  String label;
  String value;

  factory MessageType.fromJson(Map<String, dynamic> json) => MessageType(
        label: json["Label"] == null ? null : json["Label"],
        value: json["Value"] == null ? null : json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Label": label == null ? null : label,
        "Value": value == null ? null : value,
      };
}

class TotalSuggestionMessages {
  TotalSuggestionMessages({
    this.id,
    this.customerId,
    this.name,
    this.suggestionType,
    this.suggestionCategory,
    this.suggestionMessage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int customerId;
  String name;
  String suggestionType;
  String suggestionCategory;
  String suggestionMessage;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory TotalSuggestionMessages.fromJson(Map<String, dynamic> json) =>
      TotalSuggestionMessages(
        id: json["ID"] == null ? null : json["ID"],
        customerId: json["CustomerId"] == null ? null : json["CustomerId"],
        name: json["Name"] == null ? null : json["Name"],
        suggestionType:
            json["SuggestionType"] == null ? null : json["SuggestionType"],
        suggestionCategory: json["SuggestionCategory"] == null
            ? null
            : json["SuggestionCategory"],
        suggestionMessage: json["SuggestionMessage"] == null
            ? null
            : json["SuggestionMessage"],
        status: json["Status"] == null ? null : json["Status"],
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
        updatedAt: json["UpdatedAt"] == null
            ? null
            : DateTime.parse(json["UpdatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "CustomerId": customerId == null ? null : customerId,
        "Name": name == null ? null : name,
        "SuggestionType": suggestionType == null ? null : suggestionType,
        "SuggestionCategory":
            suggestionCategory == null ? null : suggestionCategory,
        "SuggestionMessage":
            suggestionMessage == null ? null : suggestionMessage,
        "Status": status == null ? null : status,
        "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
        "UpdatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
