class CardModel {
  String id;
  String name;
  String imagePath;
  int quantity;

  CardModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imagePath": imagePath,
    "quantity": quantity,
  };

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json["id"],
      name: json["name"],
      imagePath: json["imagePath"],
      quantity: json["quantity"],
    );
  }
}