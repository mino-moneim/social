import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => postBuild(context),
        separatorBuilder: (context, index) => const SizedBox(
          height: 1.0,
        ),
        itemCount: 10,
      ),
    );
  }

  Widget postBuild(context) {
    var model = SocialCubit.get(context).model;

    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model!.image),
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'June 22, 2021 at 09:45 pm',
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
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'),
            ),
            SizedBox(
              width: double.infinity,
              height: 200.0,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(model.cover),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 20.0,
                ),
                Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                  size: 20,
                ),
                Text('100'),
                Spacer(),
                Icon(
                  IconBroken.chat,
                  color: Colors.amber,
                  size: 20,
                ),
                Text('100 comment'),
                SizedBox(
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
                    backgroundImage: NetworkImage(model.image),
                    radius: 15,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Text('write a comment...'),
                  const Spacer(),
                  const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.red,
                    size: 20,
                  ),
                  const Text('like'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
