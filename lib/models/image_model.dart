import 'package:equatable/equatable.dart';

class UserImage extends Equatable {
  const UserImage({this.id, this.title, this.albumId, this.url, this.thumbnailUrl});
  final int? id;
  final String? title;
  final int? albumId;
  final String? url;
  final String? thumbnailUrl;

  factory UserImage.fromJson(Map<String, dynamic> data) => UserImage(
        id: data['id'],
        title: data['title'],
        albumId: data['albumId'],
        url: data['url'],
        thumbnailUrl: data['thumbnailUrl'],
      );
  @override
  List<dynamic> get props => [id, title, url, albumId, thumbnailUrl];
}
