// domain/usecases/get_offers.dart
import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import '../entities/offer_entity.dart';
import '../repositories/offer_repository.dart';

class GetOffers {
  final OfferRepository repository;
  GetOffers(this.repository);

  Future<Either<Failure, List<OfferEntity>>> call() async {
    return await repository.getOffers();
  }
}
