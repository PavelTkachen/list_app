part of 'page_bloc.dart';

enum PageStatus { initial, success, failure }

class PageState extends Equatable {
  const PageState({
    this.status = PageStatus.initial,
    this.posts = const <Post>[],
  });

  final PageStatus status;
  final List<Post> posts;

  PageState copyWith({
    PageStatus? status,
    List<Post>? posts,
  }) {
    return PageState(status: status ?? this.status, posts: posts ?? this.posts);
  }

  @override
  String toString() {
    return '''PageState { status: $status} {posts: $posts}''';
  }

  @override
  List<dynamic> get props => [status, posts];
}
