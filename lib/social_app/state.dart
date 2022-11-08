import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class Empty extends AppState {}

class Loading extends AppState {}

class Loaded extends AppState {}

class ThemeLoaded extends AppState {}

class LanguageLoaded extends AppState {}

class ChangeSelectedGovernment extends AppState {}

class UserLoginLoading extends AppState {}

class UserLoginSuccess extends AppState {
  final String token;

  UserLoginSuccess({
    required this.token,
  });
}

class UserLoginError extends AppState {
  final String message;

  UserLoginError({
    required this.message,
  });
}

class GetAllGovernmentsLoading extends AppState {}

class GetAllGovernmentsSuccess extends AppState {}

class GetAllGovernmentsError extends AppState {
  final String message;

  GetAllGovernmentsError({
    required this.message,
  });
}

class UserRegisterLoading extends AppState {}

class UserRegisterSuccess extends AppState {}

class UserRegisterError extends AppState {
  final String message;

  UserRegisterError({
    required this.message,
  });
}

class AllRequestedLoading extends AppState {}

class AllRequestedSuccess extends AppState {}

class AllRequestedError extends AppState {
  final String message;

  AllRequestedError({
    required this.message,
  });
}

class ChangeLoaded extends AppState {}

class PrintRequestPDF extends AppState {}

class BottomChanged extends AppState {}

class PostImagePickedSuccess extends AppState {}

class PostImagePickedError extends AppState {}

class ProfileImagePickedSuccess extends AppState {}

class ProfileImagePickedError extends AppState {}

class ProfileImageUploadSuccess extends AppState {}

class ProfileImageUploadError extends AppState {}

class GetUserError extends AppState {
  final String message;

  GetUserError({
    required this.message,
  });
}

class UserUpdateError extends AppState {}

class GetUserSuccess extends AppState {}

class GetPostsSuccess extends AppState {}

class GetMessagesSuccess extends AppState {}

class GetUsersSuccess extends AppState {}

class PostUpdatedSuccess extends AppState {}

class PostUpdatedError extends AppState {
  final String message;

  PostUpdatedError({
    required this.message,
  });
}

class SendMessage extends AppState {
  final String message;

  SendMessage({
    required this.message,
  });
}

class CreateChatError extends AppState {
  final String message;

  CreateChatError({
    required this.message,
  });
}

class GetUserLodingLoadingState extends AppState {}
class GetUserLodingSuccState extends AppState {}
class GetUserLodingErrorState extends AppState {}

class GetAllUsersLodingLoadingState extends AppState {}
class GetAllUsersLodingSuccState extends AppState {}
class GetAllUsersLodingErrorState extends AppState {}

class GetPostsLodingLoadingState extends AppState {}
class GetPostsLodingSuccState extends AppState {}
class GetPostsLodingErrorState extends AppState {}


class GetDoctorsLodingLoadingState extends AppState {}
class GetDoctorsLodingSuccState extends AppState {}
class GetDoctorsLodingErrorState extends AppState {}

class GetXLodingLoadingState extends AppState {}
class GetXLodingSuccState extends AppState {}
class GetXLodingErrorState extends AppState {}

class GetListLodingLoadingState extends AppState {}
class GetListLodingSuccState extends AppState {}
class GetListLodingErrorState extends AppState {}


class GetDoctorsLodingSuccState2 extends AppState {}


class GetNotiLodingLoadingState extends AppState {}
class GetNotiLodingSuccState extends AppState {}
class GetNotiLodingErrorState extends AppState {}

class GetAppointLodingLoadingState extends AppState {}
class GetAppointLodingSuccState extends AppState {}
class GetAppointLodingErrorState extends AppState {}

class GetResultLodingLoadingState extends AppState {}
class GetResultLodingSuccState extends AppState {}
class GetResultLodingErrorState extends AppState {}

class GetPCRLodingLoadingState extends AppState {}
class GetPCRLodingSuccState extends AppState {}
class GetPCRLodingErrorState extends AppState {}

class GetLabLodingLoadingState extends AppState {}
class GetLabLodingSuccState extends AppState {}
class GetLabLodingErrorState extends AppState {}


class GetPercLodingLoadingState extends AppState {}
class GetPercLodingSuccState extends AppState {}
class GetPercLodingErrorState extends AppState {}

class GetPharLodingLoadingState extends AppState {}
class GetPharLodingSuccState extends AppState {}
class GetPharLodingErrorState extends AppState {}

class LocationChangedState extends AppState {}