import 'package:social/models/user_model.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  late final UserModel userModel;

  LoginSuccess(this.userModel);
}

class LoginError extends LoginStates {
  final String error;

  LoginError(this.error);
}

class LoginChangeVisibility extends LoginStates {}

class RegisterLoading extends LoginStates {}

class RegisterSuccess extends LoginStates {}

class RegisterError extends LoginStates {
  final String error;

  RegisterError(this.error);
}
