part of 'products_cubit.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductsModel> products;
  final String selectedCategory;
  ProductsLoaded(this.products, {this.selectedCategory = 'All'});
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}
