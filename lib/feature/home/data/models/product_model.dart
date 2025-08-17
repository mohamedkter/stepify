// data/models/product_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.category,
    required super.description,
    required super.price,
    required super.discount,
    required super.rating,
    required super.inStock,
    required super.isPopular,
    required super.stockStatus,
    required super.sizeQuantities,
    required super.tags,
    required super.colorImages,
    required super.createdAt,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      discount: (data['discount'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      inStock: data['inStock'] ?? false,
      isPopular: data['isPopular'] ?? false,
      stockStatus: data['stockStatus'] ?? '',
      sizeQuantities: Map<String, int>.from(data['sizeQuantities'] ?? {}),
      tags: List<String>.from(data['tags'] ?? []),
      colorImages: (data['colorImages'] as List<dynamic>? ?? [])
          .map((e) => ColorImage(
                name: e['name'] ?? '',
                imageUrl: e['image'] ?? '',
              ))
          .toList(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
