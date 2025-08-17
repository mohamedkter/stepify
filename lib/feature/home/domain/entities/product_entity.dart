// domain/entities/product_entity.dart
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String description;
  final double price;
  final double discount;
  final double rating;
  final bool inStock;
  final bool isPopular;
  final String stockStatus;
  final Map<String, int> sizeQuantities;
  final List<String> tags;
  final List<ColorImage> colorImages;
  final DateTime createdAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.description,
    required this.price,
    required this.discount,
    required this.rating,
    required this.inStock,
    required this.isPopular,
    required this.stockStatus,
    required this.sizeQuantities,
    required this.tags,
    required this.colorImages,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        category,
        price,
        discount,
        rating,
        inStock,
        isPopular,
        stockStatus,
      ];
}

/// ColorImage SubEntity
class ColorImage extends Equatable {
  final String name;
  final String imageUrl;

  const ColorImage({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];
}
