import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_category_card.dart';
import '../repositories/service_category_repository.dart';

class ServiceCategoryNotifier
    extends StateNotifier<AsyncValue<List<ServiceCategoryCard>>> {
  final ServiceCategoryRepository _repository;

  ServiceCategoryNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _repository.getServiceCategories();
      state = AsyncValue.data(categories);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final serviceCategoryProvider = StateNotifierProvider<ServiceCategoryNotifier,
    AsyncValue<List<ServiceCategoryCard>>>(
  (ref) => ServiceCategoryNotifier(
    ref.watch(serviceCategoryRepositoryProvider),
  ),
);
