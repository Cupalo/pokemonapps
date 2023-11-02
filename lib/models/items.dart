class Data {
  Data({
    this.page,
    this.results,
  });

  final int? page;
  final List<Items>? results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json['page'],
        results: json["results"] == null
            ? null
            : List<Items>.from(json["results"].map((x) => Items.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Items {
  Items({
    this.name,
    this.id,
  });

  final int? id;
  final String? name;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'name': name,
      };
}
