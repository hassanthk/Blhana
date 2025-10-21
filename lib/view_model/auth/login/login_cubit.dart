import 'package:blhana_app/repository/user_repo.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepo userRepo;

  LoginCubit(this.userRepo) : super(LoginInitial());

  final email = TextEditingController();
  final pass = TextEditingController();

  String? validateField(String value, String fieldName) {
    if (value.isEmpty) return "$fieldName is required";
    return null;
  }

  Future<void> login(BuildContext context, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    try {
      await userRepo.login(
        email: email.text.trim(),
        password: pass.text.trim(),
      );

      emit(LoginSuccess());
     
      
      
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
