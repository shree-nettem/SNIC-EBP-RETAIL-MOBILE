// To parse this JSON data, do
//
//     final claimDownloadDocument = claimDownloadDocumentFromJson(jsonString);

import 'dart:convert';

ClaimDownloadDocument claimDownloadDocumentFromJson(String str) => ClaimDownloadDocument.fromJson(json.decode(str));

String claimDownloadDocumentToJson(ClaimDownloadDocument data) => json.encode(data.toJson());

class ClaimDownloadDocument {
  ClaimDownloadDocument({
    this.content,
  });

  final String content;

  factory ClaimDownloadDocument.fromJson(Map<String, dynamic> json) => ClaimDownloadDocument(
    content: json["content"] == null ? null : json["content"],
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? null : content,
  };
}
