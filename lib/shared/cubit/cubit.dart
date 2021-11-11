import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/models/user_model.dart';
import 'package:social/shared/components/uid.dart';
import 'package:social/shared/services/local/cache_helper.dart';
import 'package:social/theme.dart';
import '/screens/screens.dart';
import '/shared/cubit/states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
    FeedsScreen(),
    ChatScreen(),
    PostsScreen(),
    UsersScreen(),
  ];

  List<String> titles = const [
    'FEEDS',
    'CHATS',
    'NEW POST',
    'USERS',
  ];

  void changeIndex(int index) {
    currentIndex = index;

    emit(ChangeBottomBarIcon());
  }

  bool value = false;
  ThemeData theme = SocialTheme.light();

  void changeTheme() {
    value = !value;
    theme = value ? SocialTheme.dark() : SocialTheme.light();

    emit(ChangeTheme());
  }

  void logout() {
    // CacheHelper.removeData(key: uId);
    CacheHelper.removeAllData();

    emit(Logout());
  }

  UserModel? model;

  Future<void> getUserData() async {
    emit(UserDataLoading());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data());

      emit(UserDataSuccess());
    }).catchError((error) {
      emit(UserDataError(error.toString()));
    });
  }
}
