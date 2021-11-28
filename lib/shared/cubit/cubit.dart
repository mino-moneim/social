import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/models/message_model.dart';
import '/models/post_model.dart';
import '/models/user_model.dart';
import '/shared/services/local/cache_helper.dart';
import '/theme.dart';
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
    if (index == 1) {
      getAllUsers();
    }

    currentIndex = index;

    emit(ChangeBottomBarIcon());
  }

  bool value = false;
  ThemeData theme = SocialTheme.light();
  Color? chatColor = Colors.grey[300];

  void changeTheme() {
    value = !value;
    theme = value ? SocialTheme.dark() : SocialTheme.light();
    chatColor = value ? Colors.grey[900] : Colors.grey[300];

    emit(ChangeTheme());
  }

  void logout() {
    CacheHelper.removeAllData();

    emit(Logout());
  }

  UserModel? model;

  Future<void> getUserData() async {
    emit(UserDataLoading());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data());

      emit(UserDataSuccess());
    }).catchError((error) {
      emit(UserDataError(error.toString()));
    });
  }

  File? image;
  ImagePicker picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(ImageSelectedSuccess());
    } else {
      if (kDebugMode) {
        print('No image selected');
      }

      emit(ImageSelectedError());
    }
  }

  void uploadImage({
    String? cover,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('${model!.name}/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          cover: value,
        );

        emit(ImageUploadedSuccess());
      }).catchError((error) {
        emit(ImageUploadedError());
      });
    }).catchError((error) {
      emit(ImageUploadedError());
    });
  }

  void updateUser({
    String? cover,
  }) {
    emit(UploadedLoading());

    if (cover == null) {
      uploadImage();
      UserModel userModel = UserModel(
        name: model!.name,
        email: model!.email,
        password: model!.password,
        phone: model!.phone,
        bio: model!.bio,
        image: model!.image,
        cover: cover ?? model!.cover,
        uId: model!.uId,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(userModel.toMap())
          .then((value) {
        getUserData();
      }).then((value) {
        emit(UploadedSuccess());
      }).catchError((error) {
        emit(UploadedError());
      });
    } else {
      UserModel userModel = UserModel(
        name: model!.name,
        email: model!.email,
        password: model!.password,
        phone: model!.phone,
        bio: model!.bio,
        image: model!.image,
        cover: cover,
        uId: model!.uId,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(userModel.toMap())
          .then((value) {
        getUserData();
      }).then((value) {
        emit(UploadedSuccess());
      }).catchError((error) {
        emit(UploadedError());
      });
    }
  }

  File? postImage;
  ImagePicker postPicker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await postPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);

      emit(UploadPostImageSuccess());
    } else {
      if (kDebugMode) {
        print('No image selected');
      }

      emit(UploadPostImageError());
    }
  }

  void createPostImage({
    required String? text,
    required String? dateTime,
  }) {
    emit(CreatePostLoading());

    FirebaseStorage.instance
        .ref()
        .child(
            'posts/${model!.name}/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );

        emit(CreatePostSuccess());
      }).catchError((error) {
        emit(CreatePostError(error.toString()));
      });
    }).catchError((error) {
      emit(CreatePostError(error.toString()));
    });
  }

  void createPost({
    String? name,
    String? uId,
    String? image,
    required String? dateTime,
    String? postImage = '',
    required String? text,
    String? postId = '',
  }) {
    emit(CreatePostLoading());

    PostModel postModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      postImage: postImage,
      text: text,
      postId: postId,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      updatePostId(
        dateTime: dateTime,
        text: text,
        postId: value.id,
        postImage: postImage,
      );

      emit(CreatePostSuccess());
    }).catchError((error) {
      emit(CreatePostError(error.toString()));
    });
  }

  void updatePostId({
    String? name,
    String? uId,
    String? image,
    String? postImage,
    required String? dateTime,
    required String? text,
    required String postId,
  }) {
    PostModel postModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      postImage: postImage,
      text: text,
      postId: postId,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .update(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccess());
    }).catchError((error) {
      emit(CreatePostError(error.toString()));
    });
  }

  void removeImage() {
    postImage = null;

    emit(RemovePostImage());
  }

  List<PostModel> posts = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(GetPostsLoading());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var post in value.docs) {
        post.reference.collection('likes').get().then((value) {
          posts.add(PostModel.fromJson(post.data()));
          likes.add(value.docs.length);
        }).catchError((error) {});

        post.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {});
      }

      emit(GetPostsSuccess());
    }).catchError((error) {
      emit(GetPostsError(error.toString()));
    });
  }

  void likePost({
    required String? postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikesSuccess());
    }).catchError((error) {
      emit(LikesError(error.toString()));
    });
  }

  void commentPost({
    required String? postId,
    required String? commentText,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set({
      'comment': true,
      'commentText': commentText,
    }).then((value) {
      emit(CommentsSuccess());
    }).catchError((error) {
      emit(CommentsError(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(GetUsersLoading());

    users = [];

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var user in value.docs) {
        if (user.data()['uId'] != model!.uId)
          users.add(UserModel.fromJson(user.data()));
      }

      emit(GetUsersSuccess());
    }).catchError((error) {
      emit(GetUsersError(error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: model!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );

    // sender chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });

    // receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((message) {
        messages.add(MessageModel.fromJson(message.data()));
      });
      emit(GetMessageSuccess());
    });
  }
}
