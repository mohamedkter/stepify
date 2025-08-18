// feature/cart/data/datasources/cart_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartRemoteDataSource {
  Stream<List<CartItem>> watchCart(String uid);
  Future<void> addOrIncrement(String uid, CartItem item);
  Future<void> increment(String uid, String productId);
  Future<void> decrement(String uid, String productId);
  Future<void> remove(String uid, String productId);
  Future<void> clear(String uid);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirebaseFirestore firestore;
  CartRemoteDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      firestore.collection('users').doc(uid).collection('cart');

  @override
  Stream<List<CartItem>> watchCart(String uid) {
    return _col(uid).snapshots().map((snap) {
      return snap.docs.map((d) => CartItem.fromFirestore(d)).toList();
    });
  }

  @override
  Future<void> addOrIncrement(String uid, CartItem item) async {
    final docRef = _col(uid).doc(item.productId);
    await docRef.set({
      "name": item.name,
      "price": item.price,
      "imageUrl": item.imageUrl,
      "quantity": FieldValue.increment(item.quantity), 
    }, SetOptions(merge: true));
  }

  @override
  Future<void> increment(String uid, String productId) async {
    await _col(uid).doc(productId).update({
      "quantity": FieldValue.increment(1),
    });
  }

  @override
  Future<void> decrement(String uid, String productId) async {
    await firestore.runTransaction((txn) async {
      final ref = _col(uid).doc(productId);
      final snap = await txn.get(ref);
      if (!snap.exists) return;
      final currentQty = (snap.data()!['quantity'] as num).toInt();
      if (currentQty > 1) {
        txn.update(ref, {"quantity": currentQty - 1});
      } else {
        txn.delete(ref);
      }
    });
  }

  @override
  Future<void> remove(String uid, String productId) {
    return _col(uid).doc(productId).delete();
  }

  @override
  Future<void> clear(String uid) async {
    final batch = firestore.batch();
    final docs = await _col(uid).get();
    for (final d in docs.docs) {
      batch.delete(d.reference);
    }
    await batch.commit();
  }
}
