class HomeSearchRequestModel {
  String? search;

  HomeSearchRequestModel({this.search});

  HomeSearchRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    return data;
  }
}
