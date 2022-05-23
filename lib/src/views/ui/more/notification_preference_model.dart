class NotificationPreferencesModel {
  bool pushNotifications;
  bool emails;
  bool sMS;

  NotificationPreferencesModel({this.pushNotifications, this.emails, this.sMS});

  NotificationPreferencesModel.fromJson(Map<String, dynamic> json) {
    pushNotifications = json['PushNotifications'];
    emails = json['Emails'];
    sMS = json['SMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PushNotifications'] = this.pushNotifications;
    data['Emails'] = this.emails;
    data['SMS'] = this.sMS;
    return data;
  }
}
