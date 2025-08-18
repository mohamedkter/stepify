import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';


abstract class OrderRemoteDataSource {
  Future<void> placeOrder(OrderEntity order);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl(this.firestore);

  @override
  Future<String> placeOrder(OrderEntity order) async {
    final docRef = firestore.collection("orders").doc(); // auto ID
    await docRef.set({
      "id": docRef.id, 
      "userId": order.userId,
      "items": order.items.map((e) => e.toMap()).toList(),
      "totalPrice": order.totalPrice,
      "status": order.status,
      "paymentMethod": order.paymentMethod,
      "address": order.address,
      "createdAt": order.createdAt.toIso8601String(),
    });
    return docRef.id;
  }
}

