class Post {
  String title;
  String thumbnail;
  String description;

  Post({this.title, this.thumbnail,this.description});

  Post.fromJson(Map<String,dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    description = json['description'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    return data;
  }
}
