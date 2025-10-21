import 'package:blhana_app/pages/modules/background.dart';
import 'package:blhana_app/pages/modules/textfield.dart';
import 'package:blhana_app/repository/user_repo.dart';
import 'package:blhana_app/view_model/auth/signup/sign_up_cubit.dart';
import 'package:blhana_app/view_model/cart/cart_cubit.dart';
import 'package:blhana_app/view_model/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(UserRepo()),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) async {
          if (state is SignUpSuccess) {
            await context.read<UserCubit>().loadUserData();
            await context.read<CartCubit>().updateState();
            if (!context.mounted) return;
            Navigator.pushReplacementNamed(context, 'home');
          } else if (state is SignUpError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();
          final size = MediaQuery.of(context).size;
          return Scaffold(
            body: BackGround(
              body: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            decorationColor: Colors.black,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.1),
                            Text(
                              "First Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: size.width * 0.3),
                            Text(
                              "Last Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextField(
                              con: cubit.fname,
                              width: size.width * 0.4,
                              validator:
                                  (v) => cubit.validateField(v, "First Name"),
                            ),
                            SizedBox(width: size.width * 0.1),
                            MyTextField(
                              con: cubit.lname,
                              width: size.width * 0.4,
                              validator:
                                  (v) => cubit.validateField(v, "Last Name"),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.1),
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        MyTextField(
                          con: cubit.email,
                          width: size.width * 0.9,
                          validator: (v) => cubit.validateField(v, "Email"),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.1),
                            Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        MyTextField(
                          con: cubit.pass,
                          width: size.width * 0.9,
                          isPassword: true,
                          validator: (v) => cubit.validateField(v, "Password"),
                        ),
                        SizedBox(height: size.height * 0.04),
                        SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                            onPressed:
                                state is SignUpLoading
                                    ? null
                                    : () => cubit.signUp(context, formKey),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF056608),
                              foregroundColor: Colors.white,
                            ),
                            child:
                                state is SignUpLoading
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
                                      "Sign Up",
                                      style: TextStyle(fontSize: 24),
                                    ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            GestureDetector(
                              onTap:
                                  () => Navigator.pushReplacementNamed(
                                    context,
                                    'login',
                                  ),
                              child: Text(
                                "Login",
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
            ),
          );
        },
      ),
    );
  }
}
