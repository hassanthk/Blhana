import 'package:blhana_app/pages/modules/category_button.dart';
import 'package:blhana_app/pages/modules/products_dialog.dart';
import 'package:blhana_app/pages/modules/products_tile.dart';
import 'package:blhana_app/view_model/cart/cart_cubit.dart';
import 'package:blhana_app/view_model/cart_dialog/quabtity_cubit.dart';
import 'package:blhana_app/view_model/products/products_cubit.dart';
import 'package:blhana_app/view_model/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final firstName = state.firstName;
              final lastName = state.lastName;
              final email = state.email;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('$firstName $lastName'),
                    accountEmail: Text(email),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.green, size: 35),
                    ),
                    decoration: const BoxDecoration(color: Color(0xFF056608)),
                  ),
                  Spacer(),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      context.read<UserCubit>().logout();
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              );
            } else if (state is UserError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No user data'));
            }
          },
        ),
      ),
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
              Icons.menu,
              color: Colors.white,
              size: size.width * 0.06,
            ),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'cart'),
            child: Container(
              width: size.width * 0.2,
              height: size.width * 0.1,
              decoration: BoxDecoration(
                color: Color(0xFF056608),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: size.width * 0.06,
                  ),
                  SizedBox(width: size.width * 0.03),
                  Container(
                    width: 25,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return Text(
                          '${state is CartUpdated ? state.totalQuantity : 0}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: size.width * 0.02),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.03),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.06,
              child: TextFormField(
                onChanged: (value) {
                  context.read<ProductsCubit>().search(value);
                },
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,

                decoration: InputDecoration(
                  prefixIconColor: Colors.white,
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF056608),
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  final selectedCategory =
                      state is ProductsLoaded ? state.selectedCategory : 'All';
                  final products =
                      state is ProductsLoaded ? state.products : [];

                  return Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          CategoryButton(
                            name: 'All',
                            is_selected: selectedCategory == 'All',
                            ontap:
                                () => context
                                    .read<ProductsCubit>()
                                    .filterProducts('All'),
                          ),
                          const Spacer(),
                          CategoryButton(
                            name: 'Fast Food',
                            is_selected: selectedCategory == 'Fast Food',
                            ontap:
                                () => context
                                    .read<ProductsCubit>()
                                    .filterProducts('Fast Food'),
                          ),
                          const Spacer(),
                          CategoryButton(
                            name: 'Dinner',
                            is_selected: selectedCategory == 'Dinner',
                            ontap:
                                () => context
                                    .read<ProductsCubit>()
                                    .filterProducts('Dinner'),
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      if (state is ProductsLoading)
                        const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (state is ProductsError)
                        Expanded(
                          child: Center(
                            child: Text(
                              'Error: ${state.message}',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                          ),
                        )
                      else if (state is ProductsLoaded && products.isEmpty)
                        const Expanded(
                          child: Center(
                            child: Text(
                              'No Products Found',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      else if (state is ProductsLoaded)
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.02,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: size.width * 0.03,
                                  mainAxisSpacing: size.width * 0.03,
                                  childAspectRatio: 0.7,
                                ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductsTile(
                                name: product.title!,
                                price: product.price!,
                                imgPath: product.image!,
                                Onpressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: ProductsDialog(
                                          productTitle: product.title!,

                                          addTocart: () {
                                            context.read<CartCubit>().addItem(
                                              product,
                                              context
                                                  .read<QuantityCubit>()
                                                  .state,
                                            );
                                            context
                                                .read<QuantityCubit>()
                                                .reset();
                                            Navigator.of(context).pop();
                                          },
                                          minus: () {
                                            context
                                                .read<QuantityCubit>()
                                                .decrease();
                                          },
                                          plus: () {
                                            context
                                                .read<QuantityCubit>()
                                                .increase();
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        )
                      else
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Something went wrong!',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
