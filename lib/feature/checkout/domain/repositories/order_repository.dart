import 'package:stepify/feature/checkout/domain/entities/order.dart';


abstract class OrderRepository {
  Future<void> placeOrder(OrderEntity order);
  
  /// Live stream of the current user’s orders (newest first)
  Stream<List<OrderEntity>> watchMyOrders(String uid);

  /// One-shot fetch (newest first)
  Future<List<OrderEntity>> getMyOrdersOnce(String uid);
}
