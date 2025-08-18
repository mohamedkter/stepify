// feature/favorites/ui/cubit/favorites_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/favorite/domain/entities/favorite_item.dart';
import 'package:stepify/feature/favorite/domain/repositories/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repository;
  final String uid;

  StreamSubscription<List<FavoriteItem>>? _sub;

  FavoritesCubit({required this.repository, required this.uid})
      : super(FavoritesInitial()) {
    _listenToFavorites();
  }

  void _listenToFavorites() {
    emit(FavoritesLoading());
    _sub = repository.watchFavorites(uid).listen((items) {
      emit(FavoritesUpdated(items));
    }, onError: (e) {
      emit(FavoritesFailure(e.toString()));
    });
  }

  Future<void> toggleFavorite(FavoriteItem item) async {
    try {
      final isFav = await repository.isFavorite(uid, item.productId);
      if (isFav) {
        await repository.removeFavorite(uid, item.productId);
      } else {
        await repository.addFavorite(uid, item);
      }
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
