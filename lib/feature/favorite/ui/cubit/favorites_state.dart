// feature/favorites/ui/cubit/favorites_state.dart
import 'package:equatable/equatable.dart';
import 'package:stepify/feature/favorite/domain/entities/favorite_item.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<FavoriteItem> items;

  FavoritesUpdated(this.items);

  @override
  List<Object?> get props => [items];
}

class FavoritesFailure extends FavoritesState {
  final String message;

  FavoritesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
