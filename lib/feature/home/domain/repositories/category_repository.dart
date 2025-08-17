// domain/repositories/category_repository.dart
import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import 'package:stepify/feature/home/domain/entities/category_entity.dart';


abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
