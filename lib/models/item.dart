class Item {
  final int id;
  final int categoryId;
  final String itemName;
  final double itemAmount;
  final String dateSpent;

  Item({
    this.id,
    this.categoryId,
    this.itemName,
    this.itemAmount,
    this.dateSpent,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return Item(
      id: json['id'],
      categoryId: json['category_id'],
      itemName: json['item_name'],
      itemAmount: json['item_amount'],
      dateSpent: json['date_spent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "category_id": categoryId,
      "item_name": itemName,
      "item_amount": itemAmount,
      "date_spent": dateSpent,
    };
  }
}
