part of 'user_bloc.dart';

enum UserStatus { initial, success, failure }

class UserState extends Equatable {
  const UserState({this.status = UserStatus.initial, this.user, this.images});

  final UserStatus status;
  final User? user;
  final List<UserImage>? images;

  UserState copyWith({UserStatus? status, User? user, List<UserImage>? images}) {
    return UserState(
        status: status ?? this.status,
        user: user ?? this.user,
        images: images ?? this.images);
  }

  @override
  String toString() {
    return '''UserState { status: $status} {User: $user} {Images: $images}''';
  }

  @override
  List<Object?> get props => [status, user, images];
}
