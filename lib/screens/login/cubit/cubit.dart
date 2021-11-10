import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/user_model.dart';
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
      emit(LoginSuccess(value.user!.uid));
    }).catchError((error) {
      emit(LoginError(error.toString()));
    });
  }

  void userRegister({
    required String name,
    required String phone,
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
      userCreate(
        name: name,
        phone: phone,
        email: email,
        password: password,
        uId: value.user!.uid,
      );
      emit(RegisterSuccess());
    }).catchError((error) {
      emit(RegisterError(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String uId,
    String? image,
    String? cover,
    String? bio,
    bool? passwordVerified,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      password: password,
      phone: phone,
      uId: uId,
      image: image =
          'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png',
      cover: cover = 'https://novexconsult.com/images/placeholder.png',
      bio: bio = 'Write your bio...',
      passwordVerified: passwordVerified = false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccess());
    }).catchError((error) {
      emit(CreateUserError(error.toString()));
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
