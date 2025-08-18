// feature/favorites/data/repositories/favorites_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stepify/feature/favorite/domain/entities/favorite_item.dart';
import 'package:stepify/feature/favorite/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FirebaseFirestore firestore;

  FavoritesRepositoryImpl(this.firestore);

  @override
  Stream<List<FavoriteItem>> watchFavorites(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FavoriteItem.fromMap(doc.data()))
            .toList());
  }

  @override
  Future<void> addFavorite(String uid, FavoriteItem item) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(item.productId)
        .set(item.toMap());
  }

  @override
  Future<void> removeFavorite(String uid, String productId) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(productId)
        .delete();
  }

  @override
  Future<bool> isFavorite(String uid, String productId) async {
    final doc = await firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(productId)
        .get();
    return doc.exists;
  }
}
