import 'package:blhana_app/view_model/cart_dialog/quabtity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsDialog extends StatelessWidget {
  const ProductsDialog({
    super.key,
    required this.minus,
    required this.plus,
    required this.addTocart,
    required this.productTitle,
  });
  final VoidCallback? minus;
  final VoidCallback? plus;
  final VoidCallback? addTocart;
  final String productTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      height: size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('$productTitle', style: TextStyle(fontSize: 25)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Quantity:', style: TextStyle(fontSize: 18)),
              SizedBox(width: size.width * 0.05),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: minus,
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 28,
                    ),

                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: BlocBuilder<QuantityCubit, int>(
                        builder: (context, state) {
                          return Text(
                            '$state',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),

                    IconButton(
                      onPressed: plus,
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 28,
                    ),
                  ],
                ),
              ),
            ],
          ),

          ElevatedButton(
            onPressed: addTocart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF056608),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              'Add to Cart',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
