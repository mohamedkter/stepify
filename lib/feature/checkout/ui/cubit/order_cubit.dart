import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';
import 'package:stepify/feature/checkout/domain/repositories/order_repository.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository repository;

  OrderCubit(this.repository) : super(OrderInitial());

  Future<void> placeOrder(OrderEntity order) async {
    emit(OrderPlacing());
    try {
      await repository.placeOrder(order);
      emit(OrderPlaced());
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
