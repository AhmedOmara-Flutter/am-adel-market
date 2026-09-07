import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repos/category_repo.dart';
import '../../domain/entities/category_entity.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _categoryRepo;

  StreamSubscription<List<CategoryEntity>>? _categoriesSubscription;

  CategoryCubit(this._categoryRepo) : super(CategoryInitial());

  List<CategoryEntity> categories = [];

  void getCategories() {
    if (isClosed) return;
    emit(CategoryGetLoading());
    _categoriesSubscription?.cancel();

    _categoriesSubscription = _categoryRepo.getCategoriesStream().listen(
      (categories) {
        if (isClosed) return;
        this.categories = categories;
        emit(CategoryGetSuccess(categories: categories));
      },
      onError: (error) {
        if (isClosed) return;

        emit(CategoryGetError(message: error.toString()));
      },
    );
  }

  @override
  Future<void> close() async {
    await _categoriesSubscription?.cancel();
    _categoriesSubscription = null;
    return super.close();
  }
}
