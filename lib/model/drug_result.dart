class CardDataBaseModel {
  CardDataBaseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.cardCount,
    required this.description,
    required this.price,
    required this.basePrice,
    this.favSelected = false,
  });

  int id;
  int cardCount;
  String name;
  String image;
  String description;
  double price;
  double basePrice;
  bool favSelected;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "card_count": cardCount,
        "description": description,
        "price": price,
        "base_price": basePrice,
      };
}
