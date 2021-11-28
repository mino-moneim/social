import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/user_model.dart';
import '/screens/chats/chat_details.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

import 'chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                chatBuild(SocialCubit.get(context).users[index], context),
            itemCount: SocialCubit.get(context).users.length,
          ),
        );
      },
    );
  }

  Widget chatBuild(UserModel user, context) => Padding(
        padding: const EdgeInsets.all(1.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailsScreen(user: user),
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                    radius: 25.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
