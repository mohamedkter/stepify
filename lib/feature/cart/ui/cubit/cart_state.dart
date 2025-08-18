// feature/cart/ui/cubit/cart_state.dart

import 'package:equatable/equatable.dart';
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;
  final double total;
  final bool hasNewItems;

  CartUpdated(this.items, this.total, {this.hasNewItems = false});

  @override
  List<Object?> get props => [items, total, hasNewItems];
}

class CartFailure extends CartState {
  final String message;
  CartFailure(this.message);

  @override
  List<Object?> get props => [message];
}
