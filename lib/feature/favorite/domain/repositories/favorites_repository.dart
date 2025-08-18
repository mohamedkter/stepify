// feature/favorites/domain/repositories/favorites_repository.dart
import 'package:stepify/feature/favorite/domain/entities/favorite_item.dart';

abstract class FavoritesRepository {
  Stream<List<FavoriteItem>> watchFavorites(String uid);
  Future<void> addFavorite(String uid, FavoriteItem item);
  Future<void> removeFavorite(String uid, String productId);
  Future<bool> isFavorite(String uid, String productId);
}
