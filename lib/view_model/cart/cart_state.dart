part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;
  final double totalPrice;
  final int totalQuantity;

  CartUpdated(this.items, this.totalPrice, this.totalQuantity);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}