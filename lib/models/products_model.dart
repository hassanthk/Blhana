class ProductsModel {
  String? title;
  double? price;
  String? image;
  String? category;

  ProductsModel({
    required this.title,
    required this.price,
    required this.image,
    required this.category,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      title: map['title'] ?? '',
      price: (map['price'] as num).toDouble(),
      category: map['category'] ?? '',
      image:
          'assets/images/${map['category']}/${map['title'].toString().toLowerCase()}.jpg',
    );
  }
}
