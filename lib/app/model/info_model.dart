class InfoModel {
  InfoModel({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });

  int count;
  int pages;
  String? next;
  String? prev;

  factory InfoModel.fromMap(Map<String, dynamic> json) => InfoModel(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}
