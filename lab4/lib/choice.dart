class Choice {
  int id;
  String title;
  Choice({required this.id, required this.title});

  factory Choice.fromJson(Map<String, dynamic> json) =>
      Choice(id: json["id"], title: json["title"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title
  };
}
