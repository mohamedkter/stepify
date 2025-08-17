// data/repositories/product_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stepify/core/errors/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepositoryImpl(this.firestore);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final snapshot = await firestore.collection("products").get();
      final products = snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
