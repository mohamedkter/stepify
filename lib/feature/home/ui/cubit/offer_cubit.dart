// presentation/cubit/offer_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/usecases/get_offers.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  final GetOffers getOffers;
  OfferCubit(this.getOffers) : super(OfferInitial());

  Future<void> fetchOffers() async {
    emit(OfferLoading());
    final result = await getOffers();
    result.fold(
      (failure) => emit(OfferError(failure.errMessage)),
      (offers) => emit(OfferLoaded(offers)),
    );
  }
}
