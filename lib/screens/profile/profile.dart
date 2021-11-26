import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var image = SocialCubit.get(context).image;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: ConditionalBuilder(
                condition: SocialCubit.get(context).model != null,
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (context) => Column(
                  children: [
                    if (state is UploadedLoading)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image(
                        image:
                            NetworkImage(SocialCubit.get(context).model!.cover),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: image == null
                          ? const FlutterLogo(size: 50.0)
                          : Image(image: FileImage(image)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        SocialCubit.get(context).getImage();
                      },
                      child: const Text('pick image'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        SocialCubit.get(context).updateUser();
                      },
                      child: const Text('update'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
