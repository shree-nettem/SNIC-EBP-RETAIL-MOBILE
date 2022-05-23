class FavoriteMedicalNetwork {
  FavoriteMedicalNetwork({
    this.branchId,
    this.favorite,
  });

  String branchId;
  bool favorite;

  factory FavoriteMedicalNetwork.fromJson(Map<String, dynamic> json) =>
      FavoriteMedicalNetwork(
        branchId: json["BranchID"] == null ? null : json["BranchID"],
        favorite: json["Favorite"] == null ? null : json["Favorite"],
      );

  Map<String, dynamic> toJson() => {
        "BranchID": branchId == null ? null : branchId,
        "Favorite": favorite == null ? null : favorite,
      };
}
