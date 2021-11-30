import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({this.id, this.title, this.body, this.userId});
  final int? id;
  final String? title;
  final String? body;
  final int? userId;
  factory Post.fromJson(Map<String, dynamic> data) => Post(
        id: data['id'],
        title: data['title'],
        body: data['body'],
        userId: data['userId'],
      );
  @override
  List<dynamic> get props => [id, title, body, userId];
}
