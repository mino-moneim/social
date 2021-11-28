import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  static TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('COMMENTS'),
          ),
          body: Column(
            children: [
              TextFormField(
                controller: commentController,
                minLines: 1,
                maxLines: 150,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'comments',
                  border: const OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.send,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
