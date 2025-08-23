import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.totalPrice,
    required super.status,
    required super.paymentMethod,
    required super.address,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "items": items.map((e) => e.toMap()).toList(),
      "totalPrice": totalPrice,
      "status": status,
      "paymentMethod": paymentMethod,
      "address": address,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  factory OrderModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final createdRaw = data["createdAt"];
    final createdAt = createdRaw is Timestamp
        ? createdRaw.toDate()
        : DateTime.tryParse(createdRaw?.toString() ?? "") ?? DateTime.now();

    final itemsList = (data["items"] as List<dynamic>? ?? [])
        .map((m) => CartItem(
              productId: (m["productId"] ?? "") as String? ?? "",
              name: (m["name"] ?? "") as String? ?? "",
              price: (m["price"] as num?)?.toDouble() ?? 0.0,
              quantity: (m["quantity"] as num?)?.toInt() ?? 0,
              imageUrl: (m["imageUrl"] ?? "") as String? ?? "",
            ))
        .toList();

    return OrderModel(
      id: (data["id"] ?? doc.id) as String,
      userId: (data["userId"] ?? "") as String,
      items: itemsList,
      totalPrice: (data["totalPrice"] as num?)?.toDouble() ?? 0.0,
      status: (data["status"] ?? "pending") as String,
      paymentMethod: (data["paymentMethod"] ?? "") as String,
      address: (data["address"] ?? "") as String,
      createdAt: createdAt,
    );
  }
}
