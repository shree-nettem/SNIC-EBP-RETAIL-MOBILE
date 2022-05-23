class GhadyExistingRequestModel {
  int goal;
  int term;
  num strategy;
  String frequencyLabel;
  String status;
  num frequencyAmount;
  num lumpsum;
  int requestId;

  GhadyExistingRequestModel(
      {this.goal,
      this.term,
      this.strategy,
      this.status,
      this.frequencyLabel,
      this.frequencyAmount,
      this.lumpsum,
      this.requestId});

  GhadyExistingRequestModel.fromJson(Map<String, dynamic> json) {
    goal = json['goal'] == null ? 0 : json['goal'];
    term = json['term'] == null ? 0 : json['term'];
    strategy = json['strategy'] as num;
    status = json['Status'] ?? "";
    frequencyLabel = json['frequencyLabel'] ?? "";
    frequencyAmount = json['frequencyAmount'] as num;
    lumpsum = json['lumpsum'] as num;
    requestId = json['RequestID'] == null ? 0 : json['RequestID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goal'] = this.goal;
    data['term'] = this.term;
    data['strategy'] = this.strategy;
    data['frequencyLabel'] = this.frequencyLabel;
    data['Status'] = this.status;
    data['frequencyAmount'] = this.frequencyAmount;
    data['lumpsum'] = this.lumpsum;
    data['RequestID'] = this.requestId;
    return data;
  }
}
