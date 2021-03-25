class Category {
  final int id;
  final String categoryName;
  final double categoryLimit;
  final double totalSpent;

  Category({
    this.id,
    this.categoryName,
    this.categoryLimit,
    this.totalSpent,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return Category(
      id: json['id'],
      categoryName: json['category_name'],
      categoryLimit: json['category_limit'],
      totalSpent: json['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "category_name": categoryName,
      "category_limit": categoryLimit,
    };
  }
}
