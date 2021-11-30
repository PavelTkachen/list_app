part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataLoading extends UserEvent {
  final int? id;
  final User? user;

  DataLoading({this.id, this.user});
}

// class UserUpdate extends UserEvent {
//   final User user;
//   UserUpdate(this.user);
// }
