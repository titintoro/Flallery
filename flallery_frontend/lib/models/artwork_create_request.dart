class ArtworkCreateRequest {
  String? name;
  String? description;
  String? categoryName;

  ArtworkCreateRequest({this.name, this.description, this.categoryName});

  ArtworkCreateRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['categoryName'] = this.categoryName;
    return data;
  }
}
