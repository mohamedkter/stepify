// feature/cart/domain/repositories/cart_repository.dart
import '../entities/cart_item.dart';

abstract class CartRepository {
  Stream<List<CartItem>> watchCart(String uid);
  Future<void> addOrIncrement(String uid, CartItem item);
  Future<void> increment(String uid, String productId);
  Future<void> decrement(String uid, String productId);
  Future<void> remove(String uid, String productId);
  Future<void> clear(String uid);
}
