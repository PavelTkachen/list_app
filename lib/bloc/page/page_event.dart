part of 'page_bloc.dart';

@immutable
abstract class PageEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class DataLoading extends PageEvent {}

class LoadingSuccess extends PageEvent {}

class LoadingFailure extends PageEvent {}
