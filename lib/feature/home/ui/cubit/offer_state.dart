// presentation/cubit/offer_state.dart
part of 'offer_cubit.dart';

abstract class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object?> get props => [];
}

class OfferInitial extends OfferState {}

class OfferLoading extends OfferState {}

class OfferLoaded extends OfferState {
  final List<OfferEntity> offers;

  const OfferLoaded(this.offers);

  @override
  List<Object?> get props => [offers];
}

class OfferError extends OfferState {
  final String message;

  const OfferError(this.message);

  @override
  List<Object?> get props => [message];
}
