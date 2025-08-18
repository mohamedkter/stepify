// feature/favorites/domain/entities/favorite_item.dart
class FavoriteItem {
  final String productId;
  final String name;
  final String imageUrl;
  final double price;

  FavoriteItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      productId: map['productId'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: (map['price'] as num).toDouble(),
    );
  }
}
