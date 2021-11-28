abstract class SocialStates {}

class SocialInitial extends SocialStates {}

class ChangeBottomBarIcon extends SocialStates {}

class ChangeTheme extends SocialStates {}

class Logout extends SocialStates {}

class UserDataLoading extends SocialStates {}

class UserDataSuccess extends SocialStates {}

class UserDataError extends SocialStates {
  final String error;

  UserDataError(this.error);
}

class ImageSelectedSuccess extends SocialStates {}

class ImageSelectedError extends SocialStates {}

class ImageUploadedSuccess extends SocialStates {}

class ImageUploadedError extends SocialStates {}

class UploadedSuccess extends SocialStates {}

class UploadedError extends SocialStates {}

class UploadedLoading extends SocialStates {}

// post

class UploadPostImageSuccess extends SocialStates {}

class UploadPostImageError extends SocialStates {}

class PostImageUploadedSuccess extends SocialStates {}

class PostImageUploadedError extends SocialStates {}

class CreatePostLoading extends SocialStates {}

class CreatePostSuccess extends SocialStates {}

class CreatePostError extends SocialStates {
  final String error;

  CreatePostError(this.error);
}

class GetPostsLoading extends SocialStates {}

class GetPostsSuccess extends SocialStates {}

class GetPostsError extends SocialStates {
  final String error;

  GetPostsError(this.error);
}

class RemovePostImage extends SocialStates {}

class LikesLoading extends SocialStates {}

class LikesSuccess extends SocialStates {}

class LikesError extends SocialStates {
  final String error;

  LikesError(this.error);
}

class CommentsLoading extends SocialStates {}

class CommentsSuccess extends SocialStates {}

class CommentsError extends SocialStates {
  final String error;

  CommentsError(this.error);
}

class GetUsersLoading extends SocialStates {}

class GetUsersSuccess extends SocialStates {}

class GetUsersError extends SocialStates {
  final String error;

  GetUsersError(this.error);
}

// chat

class SendMessageSuccess extends SocialStates {}

class SendMessageError extends SocialStates {}

class GetMessageSuccess extends SocialStates {}
