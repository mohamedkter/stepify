import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderPlacing extends OrderState {}

class OrderPlaced extends OrderState {}

class OrderFailure extends OrderState {
  final String message;
  OrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}
