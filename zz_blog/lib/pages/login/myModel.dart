class MyModel {
  MyModel({
    this.id,
    this.title,
    this.body,
  });

  String? title;
  String? body;
  int? id;

  factory MyModel.fromJson(Map<String, dynamic> json) => MyModel(
    title: json["title"],
    body: json["body"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "token": title,
    "name": body,
    "id": id,
  };
}