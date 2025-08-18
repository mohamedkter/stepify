// feature/cart/ui/cubit/cart_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';
import 'package:stepify/feature/cart/domain/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;
  final String uid;

  StreamSubscription<List<CartItem>>? _sub;

  CartCubit({
    required this.repository,
    required this.uid,
  }) : super(CartInitial()) {
    _listenToCart();
  }

  void _listenToCart() {
    emit(CartLoading());
    _sub = repository.watchCart(uid).listen((items) {
      final total = items.fold<double>(
        0.0,
        (sum, i) => sum + i.price * i.quantity,
      );

      bool hasNewItems = false;
      if (state is CartUpdated) {
        hasNewItems = (state as CartUpdated).hasNewItems;
      }

      emit(CartUpdated(items, total, hasNewItems: hasNewItems));
    }, onError: (e) {
      emit(CartFailure(e.toString()));
    });
  }

  Future<void> addToCart(CartItem item) async {
    try {
      await repository.addOrIncrement(uid, item);


      if (state is CartUpdated) {
        final s = state as CartUpdated;
        emit(CartUpdated(s.items, s.total, hasNewItems: true));
      }
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> increaseQuantity(String productId) async {
    try {
      await repository.increment(uid, productId);
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> decreaseQuantity(String productId) async {
    try {
      await repository.decrement(uid, productId);
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await repository.remove(uid, productId);
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      await repository.clear(uid);
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }


  void markCartAsSeen() {
    if (state is CartUpdated) {
      final s = state as CartUpdated;
      emit(CartUpdated(s.items, s.total, hasNewItems: false));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
