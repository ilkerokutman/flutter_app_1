class Model {
  String title;
  bool completed;
  int userId;
  int id;

  Model({
    this.title,
    this.completed,
    this.userId,
    this.id,
  });

  factory Model.fromMap(Map<String, dynamic> json) => Model(
    title : json["title"],
    completed: json["completed"],
    userId: json["userId"],
    id: json["id"],
  );
}