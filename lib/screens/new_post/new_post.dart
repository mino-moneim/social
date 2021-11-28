import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/styles/icon_broken.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  static TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreatePostLoading)
                    const LinearProgressIndicator(),
                  if (state is CreatePostLoading) const SizedBox(height: 15.0),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(SocialCubit.get(context).model!.image),
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        SocialCubit.get(context).model!.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 220.0,
                    child: TextFormField(
                      controller: textController,
                      minLines: 1,
                      maxLines: 200,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'what is in your mind...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: SocialCubit.get(context).postImage == null
                        ? const SizedBox()
                        : Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Center(
                                child: Image(
                                  image: FileImage(
                                      SocialCubit.get(context).postImage!),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removeImage();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('add photo'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            var now = DateTime.now();

                            if (SocialCubit.get(context).postImage != null) {
                              SocialCubit.get(context).createPostImage(
                                text: textController.text,
                                dateTime: now.toString(),
                              );

                              textController.clear();
                              SocialCubit.get(context).removeImage();
                              SocialCubit.get(context).currentIndex = 0;
                            } else {
                              SocialCubit.get(context).createPost(
                                text: textController.text,
                                dateTime: now.toString(),
                              );

                              textController.clear();
                              SocialCubit.get(context).removeImage();
                              SocialCubit.get(context).currentIndex = 0;
                            }
                          },
                          child: const Text('POST'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
