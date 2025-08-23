import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stepify/feature/checkout/data/models/order_model.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';


abstract class OrderRemoteDataSource {
  Future<void> placeOrder(OrderEntity order);
  /// Live stream of the current user’s orders (newest first)
  Stream<List<OrderEntity>> watchMyOrders(String uid);
  /// One-shot fetch (newest first)
  Future<List<OrderEntity>> getMyOrdersOnce(String uid);
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

  @override
  Stream<List<OrderEntity>> watchMyOrders(String uid) {
    return firestore
        .collection("orders")
        .where("userId", isEqualTo: uid)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => OrderModel.fromDoc(d)).toList());
  }

  @override
  Future<List<OrderEntity>> getMyOrdersOnce(String uid) async {
    final q = await firestore
        .collection("orders")
        .where("userId", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .get();
    return q.docs.map((d) => OrderModel.fromDoc(d)).toList();
  }
}

