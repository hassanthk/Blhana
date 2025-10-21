import 'package:blhana_app/pages/modules/cart_tile.dart';
import 'package:blhana_app/view_model/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Blhana', style: TextStyle(fontFamily: 'Edu')),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            width: size.width * 0.1,
            height: size.width * 0.1,
            decoration: const BoxDecoration(
              color: Color(0xFF056608),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: size.width * 0.06,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: size.width * 0.93,
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final cartItems = state is CartUpdated ? state.items : [];
              final totalPrice = state is CartUpdated ? state.totalPrice : 0.0;
              final totalQuantity =
                  state is CartUpdated ? state.totalQuantity : 0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Text('Cart Items :', style: TextStyle(fontSize: 20)),
                      SizedBox(width: size.width * 0.02),
                      Column(
                        children: [
                          Text(
                            '$totalQuantity',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  cartItems.isEmpty
                      ? Expanded(
                        child: Center(
                          child: Text(
                            'Your cart is empty',
                            style: TextStyle(fontSize: size.width * 0.05),
                          ),
                        ),
                      )
                      : Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return CartTile(
                              img: cartItems[index].product.image,
                              price: cartItems[index].product.price,
                              title: cartItems[index].product.title,
                              quantity: cartItems[index].quantity,
                              decreseItem:
                                  () => context.read<CartCubit>().decreaseItem(
                                    cartItems[index].product,
                                  ),
                              increseItem:
                                  () => context.read<CartCubit>().increaseItem(
                                    cartItems[index].product,
                                  ),
                              deleteItem:
                                  () => context.read<CartCubit>().removeItem(
                                    cartItems[index].product,
                                  ),
                            );
                          },
                        ),
                      ),
                  Container(
                    height: size.height * 0.25,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(50),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: size.width * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF056608),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.07,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    cartItems.isEmpty
                                        ? Colors
                                            .grey 
                                        : const Color(0xFF056608),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed:
                                  cartItems.isEmpty
                                      ? null 
                                      : () {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'Success',
                                          text:
                                              'Checkout completed successfully!',
                                          onConfirmBtnTap: () {
                                            Navigator.popAndPushNamed(
                                              context,
                                              'home',
                                            );
                                            context
                                                .read<CartCubit>()
                                                .clearCart();
                                          },
                                        );
                                      },
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
