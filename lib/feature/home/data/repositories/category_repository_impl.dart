import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import 'package:stepify/feature/home/domain/entities/category_entity.dart';
import 'package:stepify/feature/home/domain/repositories/category_repository.dart';

import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(Failure(errMessage:e.toString()));
    }
  }
}
