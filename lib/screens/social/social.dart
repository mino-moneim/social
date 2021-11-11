import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/screens.dart';
import '/shared/cubit/states.dart';
import '/theme.dart';
import '/shared/cubit/cubit.dart';
import '/shared/styles/icon_broken.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return BlocProvider(
      create: (context) => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.chat,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.upload,
                ),
                label: 'New Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.user1,
                ),
                label: 'Users',
              ),
            ],
          ),
          drawer: ConditionalBuilder(
            condition: SocialCubit.get(context).model != null,
            fallback: (context) => const CircularProgressIndicator(),
            builder: (context) => Drawer(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(cubit.model!.image),
                            radius: 35,
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Expanded(
                            child: Text(
                              cubit.model!.name,
                              style: SocialTheme.darkText.headline5,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: Text(
                              cubit.model!.email,
                              style: SocialTheme.darkText.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    leading: const Icon(IconBroken.profile),
                    title: Text(
                      'Profile',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: Row(
                      children: [
                        Text(
                          'Theme',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Spacer(),
                        Switch(
                          value: cubit.value,
                          onChanged: (value) {
                            cubit.changeTheme();
                          },
                          activeColor: Colors.teal,
                          inactiveThumbColor: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(IconBroken.setting),
                    title: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(IconBroken.logout),
                    title: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onTap: () {
                      cubit.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).model != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => cubit.screens[cubit.currentIndex],
          ),
        ),
      ),
    );
  }
}
