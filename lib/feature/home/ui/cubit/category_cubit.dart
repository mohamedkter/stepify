import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_categories.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories getCategories;
  CategoryCubit(this.getCategories) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    final result = await getCategories();
    result.fold(
      (failure) => emit(CategoryError(failure.errMessage)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }
}
