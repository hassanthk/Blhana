import 'products_model.dart';

class CartItem {
  final ProductsModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price! * quantity;
}