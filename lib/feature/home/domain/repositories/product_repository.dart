// domain/repositories/product_repository.dart
import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import 'package:stepify/feature/home/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
