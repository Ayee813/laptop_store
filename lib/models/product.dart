import 'dart:convert';

class Product {
  final String productImage;
  final String productName;
  final double price;
  final String description;
  final String category;

  // Constructor to initialize the fields
  Product({
    required this.productImage,
    required this.productName,
    required this.price,
    required this.description,
    required this.category,
  });

  // Method to convert a JSON Map into a Product object (for Firebase or API responses)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productImage: map['productImage'] ?? '',
      productName: map['productName'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
    );
  }

  // Method to convert a Product object into a JSON Map (for saving to Firebase or sending to an API)
  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'productName': productName,
      'price': price,
      'description': description,
      'category': category,
    };
  }

  // Optional: Method to convert a Product to a JSON string (e.g., for storing in local storage)
  String toJson() => json.encode(toMap());

  // Optional: Method to create a Product object from a JSON string (e.g., for reading from local storage)
  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
