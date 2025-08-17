// domain/entities/offer_entity.dart
import 'package:equatable/equatable.dart';

class OfferEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool active;
  final double discount;
  final List<String> cities;

  const OfferEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.active,
    required this.discount,
    required this.cities,
  });

  @override
  List<Object?> get props => [id, title, discount, active];
}
