import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/products_model.dart';
import '/repository/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo repo;
  List<ProductsModel> _allProducts = [];
  String _currentQuery = '';
  String _currentCategory = 'All';

  ProductsCubit(this.repo) : super(ProductsInitial());

  Future<void> getAllProducts() async {
    emit(ProductsLoading());
    try {
      _allProducts = await repo.fetchProducts();
      emit(ProductsLoaded(_allProducts, selectedCategory: 'All'));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  void filterProducts(String category) {
    _currentCategory = category;
    _applyFilters();
  }

  void search(String query) {
    _currentQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    List<ProductsModel> filtered = List.from(_allProducts);

    if (_currentCategory != 'All') {
      filtered = filtered
          .where((product) => product.category == _currentCategory)
          .toList();
    }

    if (_currentQuery.isNotEmpty) {
      filtered = filtered
          .where((product) => product.title!
              .toLowerCase()
              .contains(_currentQuery.toLowerCase()))
          .toList();
    }

    emit(ProductsLoaded(filtered, selectedCategory: _currentCategory));
  }
}
