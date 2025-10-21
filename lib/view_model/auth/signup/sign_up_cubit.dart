import 'package:blhana_app/repository/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserRepo userRepo;

  SignUpCubit(this.userRepo) : super(SignUpInitial());

  final fname = TextEditingController();
  final lname = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  String? validateField(String value, String fieldName) {
    if (value.isEmpty) return "$fieldName is required";
    if (fieldName == "Password" && value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  Future<void> signUp(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (!formKey.currentState!.validate()) return;

    emit(SignUpLoading());

    try {
      await userRepo.signUp(
        firstName: fname.text.trim(),
        lastName: lname.text.trim(),
        email: email.text.trim(),
        password: pass.text.trim(),
      );

      emit(SignUpSuccess());
      Navigator.pushReplacementNamed(context, 'home');
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
