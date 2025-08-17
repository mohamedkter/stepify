// data/models/offer_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  const OfferModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.startDate,
    required super.endDate,
    required super.active,
    required super.discount,
    required super.cities,
  });

  factory OfferModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OfferModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['image'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      active: data['active'] ?? false,
      discount: (data['discount'] as num?)?.toDouble() ?? 0.0,
      cities: List<String>.from(data['cities'] ?? []),
    );
  }
}
