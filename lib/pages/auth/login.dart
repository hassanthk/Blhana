import 'package:blhana_app/pages/modules/background.dart';
import 'package:blhana_app/pages/modules/textfield.dart';
import 'package:blhana_app/view_model/auth/login/login_cubit.dart';
import 'package:blhana_app/view_model/cart/cart_cubit.dart';
import 'package:blhana_app/view_model/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          await context.read<UserCubit>().loadUserData();
          await context.read<CartCubit>().updateState();
          if (!context.mounted) return;
          Navigator.pushReplacementNamed(context, 'home');
        } else if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        final size = MediaQuery.of(context).size;

        return Scaffold(
          body: BackGround(
            body: Center(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        decorationColor: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.1),
                        Text(
                          "Email",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    MyTextField(
                      con: cubit.email,
                      width: size.width * 0.9,
                      validator: (v) => cubit.validateField(v, 'Email'),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.1),
                        Text(
                          "Password",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    MyTextField(
                      con: cubit.pass,
                      width: size.width * 0.9,
                      isPassword: true,
                      validator: (v) => cubit.validateField(v, 'Password'),
                    ),
                    SizedBox(height: size.height * 0.04),
                    SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed:
                            state is LoginLoading
                                ? null
                                : () {
                                  cubit.login(context, formkey);
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF056608),
                          foregroundColor: Colors.white,
                        ),
                        child:
                            state is LoginLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Login", style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account ?',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(width: size.width * 0.01),
                        GestureDetector(
                          onTap:
                              () => Navigator.pushReplacementNamed(
                                context,
                                'signup',
                              ),
                          child: Text(
                            "Create an account",
                            style: TextStyle(
                              color: Color(0xFF056608),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
