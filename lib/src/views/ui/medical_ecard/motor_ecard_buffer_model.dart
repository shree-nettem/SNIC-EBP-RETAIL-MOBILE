class MotorEcardBufferDataModel {
  MotorEcardBufferDataModel({
    this.result,
  });

  List<MotorEcardResult> result;

  factory MotorEcardBufferDataModel.fromJson(Map<String, dynamic> json) =>
      MotorEcardBufferDataModel(
        result: json["result"] == null
            ? null
            : List<MotorEcardResult>.from(
                json["result"].map((x) => MotorEcardResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class MotorEcardResult {
  MotorEcardResult({
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

  String buffer;
  int origin;
  int position;
  int length;
  int capacity;
  bool expandable;
  bool writable;
  bool exposable;
  bool isOpen;
  dynamic identity;

  factory MotorEcardResult.fromJson(Map<String, dynamic> json) =>
      MotorEcardResult(
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
