abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final String uId;

  LoginSuccess(this.uId);
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

class CreateUserSuccess extends LoginStates {}

class CreateUserError extends LoginStates {
  final String error;

  CreateUserError(this.error);
}
