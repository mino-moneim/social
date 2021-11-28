import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/post_model.dart';
import 'package:social/screens/comments/comments.dart';

import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';
import '/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialCubit.get(context).posts.isNotEmpty,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => postBuild(
                  SocialCubit.get(context).posts[index], context, index),
              separatorBuilder: (context, index) => const SizedBox(
                height: 1.0,
              ),
              itemCount: SocialCubit.get(context).posts.length,
            ),
          );
        });
  }

  Widget postBuild(PostModel posts, context, index) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(posts.image!),
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts.name!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        posts.dateTime!,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz_outlined)
                ],
              ),
            ),
            const SizedBox(
              height: 7.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                posts.text!,
              ),
            ),
            if (posts.postImage != '')
              SizedBox(
                width: double.infinity,
                height: 200.0,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(posts.postImage!),
                ),
              ),
            const SizedBox(
              height: 15.0,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20.0,
                ),
                const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                  size: 20,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text('${SocialCubit.get(context).likes[index]}'),
                const Spacer(),
                const Icon(
                  IconBroken.chat,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text('${SocialCubit.get(context).comments[index]}'),
                const SizedBox(
                  width: 5.0,
                ),
                const Text('comment'),
                const SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(SocialCubit.get(context).model!.image),
                    radius: 15,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommentsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'write a comment...',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        SocialCubit.get(context).likePost(postId: posts.postId);
                      },
                      icon: Row(
                        children: const [
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('like'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
