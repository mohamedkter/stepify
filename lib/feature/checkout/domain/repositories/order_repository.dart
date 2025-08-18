import 'package:stepify/feature/checkout/domain/entities/order.dart';


abstract class OrderRepository {
  Future<void> placeOrder(OrderEntity order);
}
