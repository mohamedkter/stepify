import 'package:equatable/equatable.dart';
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalPrice;
  final String status;
  final String paymentMethod;
  final String address;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.address,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, userId, items, totalPrice, status, paymentMethod, address, createdAt];
}
