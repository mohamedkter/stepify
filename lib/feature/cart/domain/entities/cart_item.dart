// feature/cart/domain/entities/cart_item.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String productId; // = documentId في Firestore
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  const CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  CartItem copyWith({
    String? productId,
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "imageUrl": imageUrl,
      };

  factory CartItem.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CartItem(
      productId: doc.id,
      name: (data["name"] ?? "") as String,
      price: (data["price"] as num).toDouble(),
      quantity: (data["quantity"] as num).toInt(),
      imageUrl: (data["imageUrl"] ?? "") as String,
    );
  }
}
