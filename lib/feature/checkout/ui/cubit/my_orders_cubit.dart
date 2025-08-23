import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';
import 'package:stepify/feature/checkout/domain/repositories/order_repository.dart';
import 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final OrderRepository repo;
  final String uid;

  StreamSubscription<List<OrderEntity>>? _sub;

  MyOrdersCubit({required this.repo, required this.uid})
      : super(MyOrdersInitial());

  void start() {
    emit(MyOrdersLoading());
    _sub?.cancel();
    _sub = repo.watchMyOrders(uid).listen((orders) {
      emit(MyOrdersLoaded(orders));
    }, onError: (e) {
      emit(MyOrdersError(e.toString()));
    });
  }

  Future<void> refresh() async {
    try {
      final list = await repo.getMyOrdersOnce(uid);
      emit(MyOrdersLoaded(list));
    } catch (e) {
      emit(MyOrdersError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
