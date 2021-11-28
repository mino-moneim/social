import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/components/toast.dart';
import '/shared/cubit/states.dart';
import '/screens/screens.dart';
import '/shared/components/uid.dart';
import '/shared/cubit/cubit.dart';
import '/shared/services/local/cache_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(
    text: 'test api from postman',
    state: ToastStates.success,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();

  print(token.toString());

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());

    showToast(
      text: 'test api from postman',
      state: ToastStates.success,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());

    showToast(
      text: 'test api from postman',
      state: ToastStates.success,
    );
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');

  Widget widget;

  if (uId != null) {
    widget = const SocialScreen();
  } else {
    widget = const LoginScreen();
  }

  runApp(SocialApp(widget: widget));
}

class SocialApp extends StatelessWidget {
  const SocialApp({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserData()
        ..getPosts(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          theme: SocialCubit.get(context).theme,
          home: widget,
        ),
      ),
    );
  }
}
