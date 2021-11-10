import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/user_model.dart';

import '/screens/login/cubit/state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(LoginSuccess(userModel!));
    }).catchError((error) {
      emit(LoginError(error.toString()));
    });
  }

  void userRegister({
    // required String name,
    //   required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoading());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(RegisterSuccess());
    }).catchError((error) {
      emit(RegisterError(error));
    });
  }

  bool isPassword = true;
  IconData passwordIcon = Icons.visibility_outlined;

  void changeIcon() {
    isPassword = !isPassword;

    passwordIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangeVisibility());
  }
}
