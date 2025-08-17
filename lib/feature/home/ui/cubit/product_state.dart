// presentation/cubit/product_state.dart
part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  ProductLoaded({required this.products});
  @override
  List<Object?> get props => [products];
}
class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});
  @override
  List<Object?> get props => [message];
}
