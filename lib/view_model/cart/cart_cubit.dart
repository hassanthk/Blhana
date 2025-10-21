import 'package:blhana_app/models/cartItems_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/products_model.dart';
import '/repository/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo;
  CartCubit(this.repo) : super(CartInitial());

  Future<void> addItem(ProductsModel product, int quantity) async {
    await repo.addToCart(product, quantity);
    await updateState();
  }

  Future<void> removeItem(ProductsModel product) async {
    await repo.removeFromCart(product);
    await updateState();
  }

  Future<void> decreaseItem(ProductsModel product) async {
    await repo.decreaseQuantity(product);
    await updateState();
  }

  Future<void> increaseItem(ProductsModel product) async {
    await repo.increaseQuantity(product);
    await updateState();
  }

  Future<void> clearCart() async {
    await repo.clearCart();
    await updateState();
  }

  Future<void> updateState() async {
    final items = await repo.getCartItems();
    final totalPrice = await repo.getTotalPrice();
    final totalQty = await repo.getTotalQuantity();

    emit(CartUpdated(items, totalPrice, totalQty));
  }
}
