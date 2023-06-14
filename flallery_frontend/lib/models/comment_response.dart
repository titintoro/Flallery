class CommentResponse {
  String? text;
  String? writer;

  CommentResponse({this.text, this.writer});

  CommentResponse.fromJson(Map<String, dynamic> json) {
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
