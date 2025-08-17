// domain/usecases/get_categories.dart
import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;
  GetCategories(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}
