class PostModel {
  String? uId;
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postId;

  PostModel({
    this.uId,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage = '',
    this.postId,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    uId = json!['uId'];
    name = json['name'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'postId': postId,
    };
  }
}
