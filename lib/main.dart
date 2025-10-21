import 'package:blhana_app/pages/auth/login.dart';
import 'package:blhana_app/pages/auth/sign_up.dart';
import 'package:blhana_app/pages/cart.dart';
import 'package:blhana_app/pages/home.dart';
import 'package:blhana_app/pages/strat.dart';
import 'package:blhana_app/repository/cart_repo.dart';
import 'package:blhana_app/repository/products_repo.dart';
import 'package:blhana_app/repository/user_repo.dart';
import 'package:blhana_app/view_model/auth/login/login_cubit.dart';
import 'package:blhana_app/view_model/auth/signup/sign_up_cubit.dart';
import 'package:blhana_app/view_model/cart/cart_cubit.dart';
import 'package:blhana_app/view_model/cart_dialog/quabtity_cubit.dart';
import 'package:blhana_app/view_model/products/products_cubit.dart';
import 'package:blhana_app/view_model/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit(UserRepo())),
        BlocProvider(create: (context) => UserCubit(UserRepo())),
        BlocProvider(create: (context) => LoginCubit(UserRepo())),
        BlocProvider(
          create: (context) => ProductsCubit(ProductsRepo())..getAllProducts(),
        ),
        BlocProvider(create: (context) => CartCubit(CartRepo())..updateState()),
        BlocProvider(create: (context) => QuantityCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Strat(),
        theme: ThemeData(fontFamily: 'oswald'),
        routes: {
          'login': (context) => Login(),
          'signup': (context) => SignUp(),
          'home': (context) => Home(),
          'cart': (context) => CartPage(),
        },
      ),
    );
  }
}
