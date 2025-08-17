// domain/repositories/offer_repository.dart
import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import '../entities/offer_entity.dart';

abstract class OfferRepository {
  Future<Either<Failure, List<OfferEntity>>> getOffers();
}
