class GiveReviewRequestModel {
  String? barId;
  int? rating;

  GiveReviewRequestModel({this.barId, this.rating});

  GiveReviewRequestModel.fromJson(Map<String, dynamic> json) {
    barId = json['bar_id'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bar_id'] = this.barId;
    data['rating'] = this.rating;
    return data;
  }
}
