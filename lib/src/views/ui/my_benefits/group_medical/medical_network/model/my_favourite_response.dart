class MyFavouritesResponse {
  String branchID;
  bool favorite;

  MyFavouritesResponse({this.branchID, this.favorite});

  MyFavouritesResponse.fromJson(Map<String, dynamic> json) {
    branchID = json['BranchID'];
    favorite = json['Favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BranchID'] = this.branchID;
    data['Favorite'] = this.favorite;
    return data;
  }
}
