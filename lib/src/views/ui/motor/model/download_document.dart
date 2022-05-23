// To parse this JSON data, do
//
//     final downloadDocumentModel = downloadDocumentModelFromJson(jsonString);

import 'dart:convert';

DownloadDocumentModel downloadDocumentModelFromJson(String str) => DownloadDocumentModel.fromJson(json.decode(str));

String downloadDocumentModelToJson(DownloadDocumentModel data) => json.encode(data.toJson());

class DownloadDocumentModel {
  DownloadDocumentModel({
    this.buffer,
    this.origin,
    this.position,
    this.length,
    this.capacity,
    this.expandable,
    this.writable,
    this.exposable,
    this.isOpen,
    this.identity,
  });

  final String buffer;
  final int origin;
  final int position;
  final int length;
  final int capacity;
  final bool expandable;
  final bool writable;
  final bool exposable;
  final bool isOpen;
  final dynamic identity;

  factory DownloadDocumentModel.fromJson(Map<String, dynamic> json) => DownloadDocumentModel(
    buffer: json["_buffer"] == null ? null : json["_buffer"],
    origin: json["_origin"] == null ? null : json["_origin"],
    position: json["_position"] == null ? null : json["_position"],
    length: json["_length"] == null ? null : json["_length"],
    capacity: json["_capacity"] == null ? null : json["_capacity"],
    expandable: json["_expandable"] == null ? null : json["_expandable"],
    writable: json["_writable"] == null ? null : json["_writable"],
    exposable: json["_exposable"] == null ? null : json["_exposable"],
    isOpen: json["_isOpen"] == null ? null : json["_isOpen"],
    identity: json["__identity"],
  );

  Map<String, dynamic> toJson() => {
    "_buffer": buffer == null ? null : buffer,
    "_origin": origin == null ? null : origin,
    "_position": position == null ? null : position,
    "_length": length == null ? null : length,
    "_capacity": capacity == null ? null : capacity,
    "_expandable": expandable == null ? null : expandable,
    "_writable": writable == null ? null : writable,
    "_exposable": exposable == null ? null : exposable,
    "_isOpen": isOpen == null ? null : isOpen,
    "__identity": identity,
  };
}
