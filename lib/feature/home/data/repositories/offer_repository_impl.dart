import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import 'package:stepify/feature/home/domain/entities/offer_entity.dart';
import 'package:stepify/feature/home/domain/repositories/offer_repository.dart';

import '../datasources/offer_remote_data_source.dart';

class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteDataSource remoteDataSource;

  OfferRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers() async {
    try {
      final offers = await remoteDataSource.getOffers();
      return Right(offers);
    } catch (e) {
      return Left(Failure(errMessage:e.toString()));
    }
  }
}
