class ArtworkList {
  List<Artwork> content;
  int totalPages;
  int totalElements;
  int pageSize;

  ArtworkList({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.pageSize,
  });

  factory ArtworkList.fromJson(Map<String, dynamic> json) {
    return ArtworkList(
      content: List<Artwork>.from(
          json['content'].map((x) => Artwork.fromJson(x))),
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      pageSize: json['pageSize'],
    );
  }
}

class Artwork {
  String name;
  String uuid;
  List<dynamic> comments;
  String owner;
  String description;

  Artwork({
    required this.name,
    required this.uuid,
    required this.comments,
    required this.owner,
    required this.description,
  });

  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork(
      name: json['name'],
      uuid: json['uuid'],
      comments: json['comments'],
      owner: json['owner'],
      description: json['description'],
    );
  }
}