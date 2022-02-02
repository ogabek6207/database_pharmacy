class DrugsModel {
  int count;
  String next;
  String previous;
  List<DrugsResult> results;

  factory DrugsModel.fromJson(Map<String, dynamic> json) => DrugsModel(
        count: json["count"] ?? 0,
        next: json["next"] ?? "",
        previous: json["previous"] ?? "",
        results: List<DrugsResult>.from(
            json["results"].map((x) => DrugsResult.fromJson(x))),
      );

  DrugsModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}

class DrugsResult {
  DrugsResult({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.basePrice,
    this.cardCount = 0,
    this.favSelected = false,
  });

  int id;
  String name;
  String image;
  String description;
  double price;
  double basePrice;
  int cardCount;
  bool favSelected;

  factory DrugsResult.fromJson(Map<String, dynamic> json) => DrugsResult(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        description: json["description"] ?? "",
        price: json["price"] ?? 0,
        basePrice: json["base_price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "base_price": basePrice,
        "card_count": cardCount,
      };
}
