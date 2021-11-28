import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/user_model.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  static TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: user.uId);

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                    radius: 20.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 40,
                    child: ConditionalBuilder(
                      condition: SocialCubit.get(context).messages.isNotEmpty,
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (SocialCubit.get(context).model!.uId ==
                              message.senderId) {
                            return myMessages(message);
                          } else {
                            return senderMessages(message, context);
                          }
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10.0,
                        ),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'write your message...',
                      border: OutlineInputBorder(),
                      suffixIcon: InkWell(
                        onTap: () {
                          SocialCubit.get(context).sendMessage(
                            receiverId: user.uId,
                            dateTime: DateTime.now().toString(),
                            text: messageController.text,
                          );
                          messageController.clear();
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget myMessages(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          child: Text(model.text!),
        ),
      );

  Widget senderMessages(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: SocialCubit.get(context).chatColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              )),
          child: Text(model.text!),
        ),
      );
}
