class ArtworkResponse {
  List<Content>? content;
  int? totalPages;
  int? totalElements;
  int? pageSize;

  ArtworkResponse(
      {this.content, this.totalPages, this.totalElements, this.pageSize});

  ArtworkResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class Content {
  String? name;
  String? uuid;
  List<Comments>? comments;
  String? owner;
  String? description;

  Content({this.name, this.uuid, this.comments, this.owner, this.description});

  Content.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uuid = json['uuid'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    owner = json['owner'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uuid'] = this.uuid;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['owner'] = this.owner;
    data['description'] = this.description;
    return data;
  }
}

class Comments {
  String? text;
  String? writer;

  Comments({this.text, this.writer});

  Comments.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    writer = json['writer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['writer'] = this.writer;
    return data;
  }
}