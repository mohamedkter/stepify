// feature/cart/data/repositories/cart_repository_impl.dart
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';
import 'package:stepify/feature/cart/domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  CartRepositoryImpl(this.remote);

  @override
  Stream<List<CartItem>> watchCart(String uid) => remote.watchCart(uid);

  @override
  Future<void> addOrIncrement(String uid, CartItem item) =>
      remote.addOrIncrement(uid, item);

  @override
  Future<void> increment(String uid, String productId) =>
      remote.increment(uid, productId);

  @override
  Future<void> decrement(String uid, String productId) =>
      remote.decrement(uid, productId);

  @override
  Future<void> remove(String uid, String productId) =>
      remote.remove(uid, productId);

  @override
  Future<void> clear(String uid) => remote.clear(uid);
}
