abstract class SocialStates {}

class SocialInitial extends SocialStates {}

class ChangeBottomBarIcon extends SocialStates {}

class ChangeTheme extends SocialStates {}

class Logout extends SocialStates {}

class UserDataLoading extends SocialStates {}

class UserDataSuccess extends SocialStates {}

class UserDataError extends SocialStates {
  final String error;

  UserDataError(this.error);
}
