import 'package:equatable/equatable.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';

abstract class MyOrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersLoaded extends MyOrdersState {
  final List<OrderEntity> orders;
  MyOrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class MyOrdersError extends MyOrdersState {
  final String message;
  MyOrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
