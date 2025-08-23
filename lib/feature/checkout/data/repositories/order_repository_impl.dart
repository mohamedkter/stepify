import 'package:stepify/feature/checkout/data/datasource/order_remote_datasource.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';
import 'package:stepify/feature/checkout/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> placeOrder(OrderEntity order) {
    return remoteDataSource.placeOrder(order);
  }
   @override
  Stream<List<OrderEntity>> watchMyOrders(String uid) => remoteDataSource.watchMyOrders(uid);

  @override
  Future<List<OrderEntity>> getMyOrdersOnce(String uid) =>remoteDataSource.getMyOrdersOnce(uid);
}
